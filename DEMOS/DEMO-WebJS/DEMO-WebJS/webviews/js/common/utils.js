!function(t){function e(t){var e=t.toString(16);return 1==e.length?"0"+e:e}function n(t){9==t.length&&(t="#"+t.slice(3));var e=/^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(t);return e?{r:parseInt(e[1],16),g:parseInt(e[2],16),b:parseInt(e[3],16)}:null}function r(t){var n=t.replace("rgb(","").replace(")","").split(",");return"#"+e(+n[0])+e(+n[1])+e(+n[2])}function a(t){var n=t.replace("rgba(","").replace(")","").split(",");return"#"+e(parseInt(255*+n[3]))+e(+n[0])+e(+n[1])+e(+n[2])}var i=function(){var t=/d{1,4}|m{1,4}|yy(?:yy)?|([HhMsTt])\1?|[LloSZ]|"[^"]*"|'[^']*'/g,e=/\b(?:[PMCEA][SDP]T|(?:Pacific|Mountain|Central|Eastern|Atlantic) (?:Standard|Daylight|Prevailing) Time|(?:GMT|UTC)(?:[-+]\d{4})?)\b/g,n=/[^-+\dA-Z]/g,r=function(t,e){for(t=String(t),e=e||2;t.length<e;)t="0"+t;return t};return function(a,o,m){var s=i;if(1!=arguments.length||"[object String]"!=Object.prototype.toString.call(a)||/\d/.test(a)||(o=a,a=void 0),a=a?new Date(a):new Date,isNaN(a))throw SyntaxError("invalid date");o=String(s.masks[o]||o||s.masks["default"]),"UTC:"==o.slice(0,4)&&(o=o.slice(4),m=!0);var u=m?"getUTC":"get",d=a[u+"Date"](),l=a[u+"Day"](),c=a[u+"Month"](),h=a[u+"FullYear"](),g=a[u+"Hours"](),y=a[u+"Minutes"](),f=a[u+"Seconds"](),M=a[u+"Milliseconds"](),T=m?0:a.getTimezoneOffset(),b={d:d,dd:r(d),ddd:s.i18n.dayNames[l],dddd:s.i18n.dayNames[l+7],m:c+1,mm:r(c+1),mmm:s.i18n.monthNames[c],mmmm:s.i18n.monthNames[c+12],yy:String(h).slice(2),yyyy:h,h:g%12||12,hh:r(g%12||12),H:g,HH:r(g),M:y,MM:r(y),s:f,ss:r(f),l:r(M,3),L:r(M>99?Math.round(M/10):M),t:12>g?"a":"p",tt:12>g?"am":"pm",T:12>g?"A":"P",TT:12>g?"AM":"PM",Z:m?"UTC":(String(a).match(e)||[""]).pop().replace(n,""),o:(T>0?"-":"+")+r(100*Math.floor(Math.abs(T)/60)+Math.abs(T)%60,4),S:["th","st","nd","rd"][d%10>3?0:(d%100-d%10!=10)*d%10]};return o.replace(t,function(t){return t in b?b[t]:t.slice(1,t.length-1)})}}();i.masks={"default":"ddd mmm dd yyyy HH:MM:ss",shortDate:"m/d/yy",mediumDate:"mmm d, yyyy",longDate:"mmmm d, yyyy",fullDate:"dddd, mmmm d, yyyy",shortTime:"h:MM TT",mediumTime:"h:MM:ss TT",longTime:"h:MM:ss TT Z",isoDate:"yyyy-mm-dd",isoTime:"HH:MM:ss",isoDateTime:"yyyy-mm-dd'T'HH:MM:ss",isoUtcDateTime:"UTC:yyyy-mm-dd'T'HH:MM:ss'Z'"},i.i18n={dayNames:["周日","周一","周二","周三","周四","周五","周六","星期日","星期一","星期二","星期三","星期四","星期五","星期六"],monthNames:["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec","一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]},Date.prototype.format=function(t,e){return i(this,t,e)};var o={rgbToHex:r,rgbaToHex:a,hexToRgb:n,interpolateRgb:function(t,r,a){t=n(t),r=n(r);var i=t.r,o=t.g,m=t.b,s=r.r-i,u=r.g-o,d=r.b-m;return function(t){var n=Math.round(i+s*t),r=Math.round(o+u*t),l=Math.round(m+d*t);return"rgb"==a?"rgb("+n+","+r+","+l+")":"#"+e(n)+e(r)+e(l)}},getColorWithAlpha:function(t,e){return t=n(t),"rgba("+t.r+", "+t.g+", "+t.b+", "+e+")"},scale:function(t,e){return e||(e=[0,1]),function(n){return t[1]==t[0]?e[1]:e[0]+(e[1]-e[0])*(n-t[0])/(t[1]-t[0])}},max:function(t){for(var e=0,n=0;n<t.length;n++)e=Math.max(t[n],e);return e},min:function(t){for(var e=0,n=0;n<t.length;n++)e=Math.min(t[n],e);return e},dx:function(t){if(!t||0==t.length)return 0;for(var e=0,n=0,r=0;r<t.length;r++)e+=t[r];for(n=e/t.length,r=0,e=0;r<t.length;r++)e+=Math.pow(t[r]-n,2);return Math.sqrt(e/t.length)},formatLngAndLat:function(t,e){return e=void 0===e?2:e,new Number(t).toFixed(e)+"°"},formatNumber:function(t,e,n,r){var a=+t||0,i=-1===e?Math.min((a.toString().split(".")[1]||"").length,20):isNaN(e=Math.abs(e))?2:e,o=void 0===n?".":n,m=void 0===r?",":r,s=0>a?"-":"",u=String(parseInt(a=Math.abs(a).toFixed(i))),d=u.length>3?u.length%3:0;return s+(d?u.substr(0,d)+m:"")+u.substr(d).replace(/(\d{3})(?=\d)/g,"$1"+m)+(i?o+Math.abs(a-u).toFixed(i).slice(2):"")},formatDataLabel:function(t,e,n){var r=2;return t?(""!==t[t.check].digit&&(r=t[t.check].digit),e="num"==t.check&&t.num.millesimal?o.formatNumber(e,r,".",","):"num"==t.check?o.formatNumber(e,r,".",""):o.formatNumber(100*e,r,".","")+"%"):(("COUNT"==n||"COUNT_DISTINCT"==n)&&(r=0),e=o.formatNumber(e,r)),e},formatDate:i};t.utils=o}(window);