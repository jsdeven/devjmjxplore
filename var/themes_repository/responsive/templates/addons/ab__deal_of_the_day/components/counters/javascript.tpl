<script>
    (function (_, $) {
        $(document).ready(function() {
            $.getScript('js/addons/ab__deal_of_the_day/js_counter.js', function () {
                ab_dotd_js_counter('ab__deal_of_the_day_{$block.block_id}', {$total_seconds}, {
                    'days'    : '{__('ab__dotd.countdown.days')}',
                    'hours'   : '{__('ab__dotd.countdown.hours')}',
                    'minutes' : '{__('ab__dotd.countdown.minutes')}',
                    'seconds' : '{__('ab__dotd.countdown.seconds')}'
                });
            });
        });
    })(Tygh, Tygh.$);
</script>