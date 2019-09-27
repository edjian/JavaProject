<!--
  - Copyright (C) 2018-2019
  - All rights reserved, Designed By www.joolun.com
  - 注意：
  - 本软件为www.joolun.com开发研制，未经购买不得使用
  - 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
  - 一经发现盗用、分享等行为，将追究法律责任，后果自负
-->
<template>
  <div id="wxEditor">
    <froala :tag="'textarea'" :config="config" v-model="content"></froala>
  </div>
</template>

<script>
  import 'froala-editor/js/plugins.pkgd.min.js'
  import 'froala-editor/js/froala_editor.pkgd.min.js'
  import 'froala-editor/js/plugins/link.min.js'
  import 'froala-editor/js/plugins/image.min.js'
  import 'froala-editor/js/plugins/image_manager.min.js'
  import 'froala-editor/css/plugins/image_manager.min.css'
  import store from "@/store"

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
    name: 'wxEditor',
    data() {
      return {
        config: {
          language: 'zh_cn',
          requestHeaders: {
            Authorization: 'Bearer ' + store.getters.access_token
          },
          imageUploadURL: '/weixin/wxmaterial/newsImgUpload',
          imageUploadParams: {
            appId: this.uploadData.appId
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
          imageInsertButtons: ['imageBack', '|', 'imageUpload', 'imageManager'],
          imageEditButtons: ['imageReplace', 'imageAlign', 'imageRemove', '|', 'imageLink', 'linkOpen', 'linkEdit', 'linkRemove', '-', 'imageDisplay', 'imageStyle', 'imageAlt', 'imageSize'],
          imageManagerLoadURL: '/weixin/wxmaterial/page-manager',
          imageManagerLoadParams: {
            appId: this.uploadData.appId,
            type: 'image',
            count: 20,
            offset: 0
          },
          imageManagerPageSize: 20,
          imageManagerScrollOffset: 1,
          videoInsertButtons: ['videoBack', '|', 'videoByURL'],
          zIndex: 99999,
          events: {
            //https://www.froala.com/wysiwyg-editor/docs/events
            'contentChanged': () => {
              this.$emit('input', this.content)
            },
            'imageManager.error': function (error, response) {
              alert('图片加载出错')
            }
          }
        },
        content: this.value.replace(/data-src/g, "src")
      }
    },
    methods: {}
  }
</script>
