/*******************************************************************************************
*   ___  _          ______                     _ _                _                        *
*  / _ \| |         | ___ \                   | (_)              | |              © 2021   *
* / /_\ | | _____  _| |_/ /_ __ __ _ _ __   __| |_ _ __   __ _   | |_ ___  __ _ _ __ ___   *
* |  _  | |/ _ \ \/ / ___ \ '__/ _` | '_ \ / _` | | '_ \ / _` |  | __/ _ \/ _` | '_ ` _ \  *
* | | | | |  __/>  <| |_/ / | | (_| | | | | (_| | | | | | (_| |  | ||  __/ (_| | | | | | | *
* \_| |_/_|\___/_/\_\____/|_|  \__,_|_| |_|\__,_|_|_| |_|\__, |  \___\___|\__,_|_| |_| |_| *
*                                                         __/ |                            *
*                                                        |___/                             *
* ---------------------------------------------------------------------------------------- *
* This is commercial software, only users who have purchased a valid license and accept    *
* to the terms of the License Agreement can install and use this program.                  *
* ---------------------------------------------------------------------------------------- *
* website: https://cs-cart.alexbranding.com                                                *
*   email: info@alexbranding.com                                                           *
*******************************************************************************************/
function ab_dotd_js_counter (id, total_seconds, langs) {
var elem = document.getElementById(id);
if (total_seconds <= 0 || elem.dataset.ab__dotd_inited !== undefined) {
return true;
}
elem.dataset.ab__dotd_inited = true;
elem.style.visibility = 'hidden';
var days = document.createElement('div');
days.className = 'ab-dotd-js-counter_days';
days.innerHTML = '<span></span>' + langs.days;
elem.appendChild(days);
var hours = document.createElement('div');
hours.className = 'ab-dotd-js-counter_hours';
hours.innerHTML = '<span></span>' + langs.hours;
elem.appendChild(hours);
var minutes = document.createElement('div');
minutes.className = 'ab-dotd-js-counter_minutes';
minutes.innerHTML = '<span></span>' + langs.minutes;
elem.appendChild(minutes);
var seconds = document.createElement('div');
seconds.className = 'ab-dotd-js-counter_seconds';
seconds.innerHTML = '<span></span>' + langs.seconds;
elem.appendChild(seconds);
var interval = setInterval(function() {
total_seconds--;
var days_count = Math.floor(total_seconds / (60 * 60 * 24));
if (days_count === 0) {
days.style.display = 'none';
}
days.firstChild.innerHTML = days_count;
hours.firstChild.innerHTML = Math.floor((total_seconds % (60 * 60 * 24)) / (60 * 60));
minutes.firstChild.innerHTML = Math.floor((total_seconds % (60 * 60)) / (60));
seconds.firstChild.innerHTML = Math.floor((total_seconds % (60)));
if (total_seconds < 0) {
clearInterval(interval);
}
elem.style.visibility = 'visible';
}, 1000);
}