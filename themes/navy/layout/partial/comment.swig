{% if page.comments && config.disqus_shortname %}
<section id="comments">
  <div id="disqus_thread"></div>
</section>

<link rel="stylesheet" href="https://imsun.github.io/gitment/style/default.css">
<script src="https://imsun.github.io/gitment/dist/gitment.browser.js"></script>
<script>
var gitment = new Gitment({
  owner: 'tidyjiang8',
  repo: 'zephyrproject.cn.comments',
  oauth: {
    client_id: 'ad0b343a10e201965ac6',
    client_secret: '4cc2c3eca459a20aea9720095da3c591685a8986',
  },
})
gitment.render('disqus_thread')
</script>

<script>

</script>
{% endif %}
