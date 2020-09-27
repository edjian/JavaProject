<!--
  - Copyright (C) 2018-2019
  - All rights reserved, Designed By www.joolun.com
  - 注意：
  - 本软件为www.joolun.com开发研制，未经购买不得使用
  - 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
  - 一经发现盗用、分享等行为，将追究法律责任，后果自负
-->
<template>
  <div id="baseEditor">
    <froala :tag="'textarea'" :config="config" v-model="content" v-if="editorType == '2'"></froala>
    <div v-loading="quillUpdateImg" element-loading-text="请稍等，图片上传中" v-if="editorType == '1'">
      <!-- 图片上传组件辅助-->
      <quill-editor
              class="editor"
              v-model="content"
              ref="myQuillEditor"
              :options="editorOption"
              @blur="onEditorBlur($event)"
              @focus="onEditorFocus($event)"
              @change="onEditorChange($event)">
      </quill-editor>
    </div>
  </div>
</template>

<script>
  // 工具栏配置
  const toolbarOptions = [
    ["bold", "italic", "underline", "strike"], // 加粗 斜体 下划线 删除线
    ["blockquote", "code-block"], // 引用  代码块
    [{ header: 1 }, { header: 2 }], // 1、2 级标题
    [{ list: "ordered" }, { list: "bullet" }], // 有序、无序列表
    [{ script: "sub" }, { script: "super" }], // 上标/下标
    [{ indent: "-1" }, { indent: "+1" }], // 缩进
    // [{'direction': 'rtl'}],                         // 文本方向
    [{ size: ["small", false, "large", "huge"] }], // 字体大小
    [{ header: [1, 2, 3, 4, 5, 6, false] }], // 标题
    [{ color: [] }, { background: [] }], // 字体颜色、字体背景颜色
    [{ font: [] }], // 字体种类
    [{ align: [] }], // 对齐方式
    ["clean"], // 清除文本格式
    ["link", "image", "video"] // 链接、图片、视频
  ]

  import { quillEditor, Quill } from "vue-quill-editor"
  import "quill/dist/quill.core.css"
  import "quill/dist/quill.snow.css"
  import "quill/dist/quill.bubble.css"
  import 'froala-editor/js/plugins.pkgd.min.js'
  import 'froala-editor/js/froala_editor.pkgd.min.js'
  import 'froala-editor/js/plugins/link.min.js'
  import 'froala-editor/js/plugins/image.min.js'
  import 'froala-editor/js/plugins/image_manager.min.js'
  import 'froala-editor/css/plugins/image_manager.min.css'
  import store from "@/store"
  import {getObj2} from '@/api/upms/configeditor'

  const Delta = Quill.import('delta')
  export default {
    props: {
      uploadData: {
        type: Object
      },
      /*编辑器的内容*/
      value: {
        type: String
      },
      /*图片大小*/
      maxSize: {
        type: Number,
        default: 4000 //kb
      }
    },
    name: 'baseEditor',
    components: {
      quillEditor
    },
    data() {
      return {
        editorType: '',
		imgSign: {},
        config: {
          language: 'zh_cn',
          requestHeaders: {
            Authorization: 'Bearer ' + store.getters.access_token
          },
          imageUploadURL: '/upms/file/upload',
          imageUploadParams: {
            dir: 'editor/',
            fileType: 'image'
          },
          toolbarButtons: {
            'moreText': {
              'buttons': ['bold', 'italic', 'underline', 'strikeThrough', 'subscript', 'superscript', 'fontFamily', 'fontSize', 'textColor', 'backgroundColor', 'inlineClass', 'inlineStyle', 'clearFormatting']
            },
            'moreParagraph': {
              'buttons': ['alignLeft', 'alignCenter', 'formatOLSimple', 'alignRight', 'alignJustify', 'formatOL', 'formatUL', 'paragraphFormat', 'paragraphStyle', 'lineHeight', 'outdent', 'indent', 'quote']
            },
            'moreRich': {
              'buttons': ['insertLink', 'insertImage', 'insertVideo', 'insertTable', 'emoticons', 'fontAwesome', 'specialCharacters', 'embedly', 'insertHR']
            },
            'moreMisc': {
              'buttons': ['undo', 'redo', 'fullscreen', 'print', 'getPDF', 'spellChecker', 'selectAll', 'html', 'help'],
              'align': 'right',
              'buttonsVisible': 2
            }
          },
          fontFamilySelection: true,
          fontSizeSelection: true,
          paragraphFormatSelection: true,
          quickInsertButtons: ['image', 'table', 'ul', 'ol', 'hr'],//快速插入项
          linkInsertButtons: ['linkBack'],
          imageInsertButtons: ['imageBack', '|', 'imageUpload'],
          imageEditButtons: ['imageReplace', 'imageAlign', 'imageRemove', '|', 'imageLink', 'linkOpen', 'linkEdit', 'linkRemove', '-', 'imageDisplay', 'imageStyle', 'imageAlt', 'imageSize'],
          videoInsertButtons: ['videoBack', '|', 'videoByURL'],
          zIndex: 99999,
          events: {
            //https://www.froala.com/wysiwyg-editor/docs/events
            'contentChanged': () => {
              this.$emit('input', this.content)
            }
          }
        },

        content: this.value,

        quillUpdateImg: false, // 根据图片上传状态来确定是否显示loading动画，刚开始是false,不显示
        editorOption: {
          placeholder: "",
          theme: "snow", // or 'bubble'
          placeholder: "请输入文章内容",
          modules: {
            toolbar: {
              container: toolbarOptions,
              // container: "#toolbar",
              handlers: {
                image: function(value) {
                  if (value) {
                    // 触发input框选择图片文件
                    document.querySelector(".avatar-uploader input").click();
                  } else {
                    this.quill.format("image", false);
                  }
                },
                link: function(value) {
                  if (value) {
                    var href = prompt('注意！只支持公众号图文链接');
                    this.quill.format("link", href);
                  } else {
                    this.quill.format("link", false);
                  }
                },
              }
            }
          }
        },
        serverUrl: "/upms/file/upload?fileType=image&dir=editor/", // 这里写你要上传的图片服务器地址
        header: {
          Authorization: 'Bearer ' + store.getters.access_token
        } // 有的图片服务器要求请求头需要有token
      }
    },
    created() {
      this.handleGet()
    },
    methods: {
      handleGet: function () {
        getObj2().then(response => {
          this.editorType = response.data.data ? response.data.data.editorType : '1'
		  this.imgSign = response
		  this.setEditorOption() 
        })
      },
	  
	  setEditorOption() {
                // 当前组件实例      
                let vm = this				
                this.editorOption = Object.assign(this.editorOption, {        
                    placeholder: '请插入内容...',       
                    modules: {          
                        toolbar: {            
                            container: toolbarOptions,           
                             handlers: {              
                                // 自定义上传图片到服务器             
                                image: function() { 
                                    // quill插件实例               
                                    let _self = this  
                                    // 创建上传文件input并触发
                                    let fileInput = document.createElement('input')                
                                    fileInput.setAttribute('type', 'file')                
                                    fileInput.setAttribute('multiple', 'multiple')                
                                    fileInput.setAttribute('accept', 'image/*')                
                                    fileInput.addEventListener('change', () => {                  
                                        if (fileInput.files !== null) {                    
                                            const files = Array.from(fileInput.files).reverse()                    
                                            // 利用es6迭代器异步顺序上传图片，保证图片插入顺序正常                  
                                            const it = files[Symbol.iterator]()                    
                                            uploadFile()   
                 
                                            function uploadFile () {                      
                                               const { done, value: _file } = it.next()                      
                                                if (done) return                      
                                                let reader = new FileReader()                      
                                                reader.onload = (event) => { 											
                                                    const range = _self.quill.getSelection(true)  
                                                    // 设置图片上传地址
                                                    const uploadImgServer = '/upms/file/upload?fileType=image&dir=editor/'                        
                                                    // 创建formData参数提交（文件+签名信息）                  
                                                    const formData = new FormData()                        
                                                    formData.append('file', _file)                        
                                                    for (const [key, val] of Object.entries(vm.imgSign)) {                          
                                                        formData.append(key, val)                        
                                                    }                        
                                                    // 发送图片上传请求                     
                                                    const xhr = new XMLHttpRequest()                        
                                                    xhr.open('POST', uploadImgServer)
													xhr.setRequestHeader('Authorization', 'Bearer ' + store.getters.access_token)
                                                    xhr.timeout = 6000                        
                                                    xhr.ontimeout = () => {                          
                                                        alert('图片上传超时')                        
                                                    }                        
                                                    xhr.onreadystatechange = () => {                          
                                                        let result                          
                                                        if (xhr.readyState === 4) {                                            
                                                            // http status code                            
                                                            if (xhr.status < 200 || xhr.status >= 300) {   
                                                                return alert(`上传图片发生错误，上传图片发生错误，服务器返回状态是 ${xhr.status}`)                            
                                                            }                            
                                                            result = xhr.responseText                            
                                                            if (typeof result !== 'object') {                              
                                                                try {                                
                                                                    result = JSON.parse(result)                              
                                                                } catch {                                
                                                                    return alert('上传图片失败', '上传图片返回结果错误，返回结果是: ' + result)                              
                                                                }                            
                                                            } 
                                                            // 根据服务器返回的结果自行拼接图片地址
                                                            //const URI = result.data.items.file.map(v => `/upms/file/upload?fileType=image&dir=editor/${v.filename}`)[0]
                                                            // 插入到文本                            
                                                            _self.quill.updateContents(                              
                                                                new Delta()                                
                                                                    .retain(range.index)                                
                                                                    .delete(range.length)                                
                                                                    .insert({ image: result.link })                            
                                                            )                          
                                                        }                          
                                                        // 上传下一个图片                         
                                                        uploadFile()                        
                                                    }                        
                                                    xhr.send(formData)                      
                                                }                      
                                                reader.readAsDataURL(_file)                    
                                            }       
                                        }                
                                    })                
                                    fileInput.click()              
                                }            
                            }         
                        }        
                    }      
                })
		}, 
      onEditorBlur(editor) {
        //失去焦点事件
      },
      onEditorFocus(editor) {
        //获得焦点事件
      },
      onEditorChange(editor) {
        //内容改变事件
        this.$emit("input", this.content)
      },

      // 富文本图片上传前
      beforeUpload() {
        // 显示loading动画
        this.quillUpdateImg = true
      },

      uploadSuccess(res, file) {
        // res为图片服务器返回的数据
        // 获取富文本组件实例
        let quill = this.$refs.myQuillEditor.quill
        // 如果上传成功
        if(res.link){
          // 获取光标所在位置
          let length = quill.getSelection().index;
          // 插入图片  res.info为服务器返回的图片地址
          quill.insertEmbed(length, 'image', res.link)
          // 调整光标到最后
          quill.setSelection(length + 1)
        } else {
          this.$message.error('图片插入失败')
        }
        // loading动画消失
        this.quillUpdateImg = false;
      },
      // 富文本图片上传失败
      uploadError() {
        // loading动画消失
        this.quillUpdateImg = false;
        this.$message.error("图片插入失败");
      }
    }
  }
</script>

<style>
  .editor {
    line-height: normal !important;
    height: 400px;
  }
  .ql-snow .ql-tooltip[data-mode=link]::before {
    content: "请输入链接地址:";
  }
  .ql-snow .ql-tooltip.ql-editing a.ql-action::after {
    border-right: 0px;
    content: '保存';
    padding-right: 0px;
  }

  .ql-snow .ql-tooltip[data-mode=video]::before {
    content: "请输入视频地址:";
  }

  .ql-snow .ql-picker.ql-size .ql-picker-label::before,
  .ql-snow .ql-picker.ql-size .ql-picker-item::before {
    content: '14px';
  }
  .ql-snow .ql-picker.ql-size .ql-picker-label[data-value=small]::before,
  .ql-snow .ql-picker.ql-size .ql-picker-item[data-value=small]::before {
    content: '10px';
  }
  .ql-snow .ql-picker.ql-size .ql-picker-label[data-value=large]::before,
  .ql-snow .ql-picker.ql-size .ql-picker-item[data-value=large]::before {
    content: '18px';
  }
  .ql-snow .ql-picker.ql-size .ql-picker-label[data-value=huge]::before,
  .ql-snow .ql-picker.ql-size .ql-picker-item[data-value=huge]::before {
    content: '32px';
  }

  .ql-snow .ql-picker.ql-header .ql-picker-label::before,
  .ql-snow .ql-picker.ql-header .ql-picker-item::before {
    content: '文本';
  }
  .ql-snow .ql-picker.ql-header .ql-picker-label[data-value="1"]::before,
  .ql-snow .ql-picker.ql-header .ql-picker-item[data-value="1"]::before {
    content: '标题1';
  }
  .ql-snow .ql-picker.ql-header .ql-picker-label[data-value="2"]::before,
  .ql-snow .ql-picker.ql-header .ql-picker-item[data-value="2"]::before {
    content: '标题2';
  }
  .ql-snow .ql-picker.ql-header .ql-picker-label[data-value="3"]::before,
  .ql-snow .ql-picker.ql-header .ql-picker-item[data-value="3"]::before {
    content: '标题3';
  }
  .ql-snow .ql-picker.ql-header .ql-picker-label[data-value="4"]::before,
  .ql-snow .ql-picker.ql-header .ql-picker-item[data-value="4"]::before {
    content: '标题4';
  }
  .ql-snow .ql-picker.ql-header .ql-picker-label[data-value="5"]::before,
  .ql-snow .ql-picker.ql-header .ql-picker-item[data-value="5"]::before {
    content: '标题5';
  }
  .ql-snow .ql-picker.ql-header .ql-picker-label[data-value="6"]::before,
  .ql-snow .ql-picker.ql-header .ql-picker-item[data-value="6"]::before {
    content: '标题6';
  }

  .ql-snow .ql-picker.ql-font .ql-picker-label::before,
  .ql-snow .ql-picker.ql-font .ql-picker-item::before {
    content: '标准字体';
  }
  .ql-snow .ql-picker.ql-font .ql-picker-label[data-value=serif]::before,
  .ql-snow .ql-picker.ql-font .ql-picker-item[data-value=serif]::before {
    content: '衬线字体';
  }
  .ql-snow .ql-picker.ql-font .ql-picker-label[data-value=monospace]::before,
  .ql-snow .ql-picker.ql-font .ql-picker-item[data-value=monospace]::before {
    content: '等宽字体';
  }
</style>

