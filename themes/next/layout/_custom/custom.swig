{# wobble窗口摆动特效 #}
{% if theme.wobble %}
  <script src="/js/src/wobblewindow.js"></script>
  <script>
    //只在桌面版网页启用特效
    if( window.innerWidth > 768  ){
      $(document).ready(function () {
        {% if theme.wobble.header %}
          $('#header').wobbleWindow({
            radius: {{ theme.wobble.radius }},
            movementTop: false,
            movementLeft: false,
            movementRight: false,
            debug: false,
          });
        {% endif %}

        {% if theme.wobble.sidebar %}
          $('#sidebar').wobbleWindow({
            radius: {{ theme.wobble.radius }},
            movementLeft: false,
            movementTop: false,
            movementBottom: false,
            position: 'fixed',
            debug: false,
          });
        {% endif %}

        {% if theme.wobble.footer %}
          $('#footer').wobbleWindow({
            radius: {{ theme.wobble.radius }},
            movementBottom: false,
            movementLeft: false,
            movementRight: false,
            offsetX: {{ theme.wobble.offset }},
            position: 'absolute',
            debug: false,
          });
        {% endif %}
      });
    }
  </script>
{% endif %}


{# 鼠标点击特效 #}
{% if theme.cursor_effect == "fireworks" %}
  <script async src="/js/src/cursor.js"></script>
{% endif %}


{# 搞怪网页标题 #}
{% if theme.title_trick.enable %}
  <script>
    var OriginTitile = document.title;
    var titleTime;
    document.addEventListener('visibilitychange', function() {
      if (document.hidden) {
        document.title = '{{ theme.title_trick.leave }}' + OriginTitile;
        clearTimeout(titleTime);
      } else {
        document.title = '{{ theme.title_trick.enter }}' + OriginTitile;
        titleTime = setTimeout(function() {
          document.title = OriginTitile;
        }, 2000);
      }
    });
  </script>
{% endif %}