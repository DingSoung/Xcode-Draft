!function(t){function r(){}function e(t,r,e){if(t){var n=0,o=t.length,i=r[0],s=r[1],f=r[2],a=!0;switch(r.length){case 0:for(;o>n;n+=2)a=t[n].call(t[n+1]||e)!==!1&&a;break;case 1:for(;o>n;n+=2)a=t[n].call(t[n+1]||e,i)!==!1&&a;break;case 2:for(;o>n;n+=2)a=t[n].call(t[n+1]||e,i,s)!==!1&&a;break;case 3:for(;o>n;n+=2)a=t[n].call(t[n+1]||e,i,s,f)!==!1&&a;break;default:for(;o>n;n+=2)a=t[n].apply(t[n+1]||e,r)!==!1&&a}}return a}function n(t){return"[object Function]"===Object.prototype.toString.call(t)}var o=/\s+/;r.prototype.on=function(t,r,e){var n,i,s;if(!r)return this;for(n=this.__events||(this.__events={}),t=t.split(o);i=t.shift();)s=n[i]||(n[i]=[]),s.push(r,e);return this},r.prototype.once=function(t,r,e){var n=this,o=function(){n.off(t,o),r.apply(this,arguments)};this.on(t,o,e)},r.prototype.off=function(t,r,e){var n,s,f,a;if(!(n=this.__events))return this;if(!(t||r||e))return delete this.__events,this;for(t=t?t.split(o):i(n);s=t.shift();)if(f=n[s])if(r||e)for(a=f.length-2;a>=0;a-=2)r&&f[a]!==r||e&&f[a+1]!==e||f.splice(a,2);else delete n[s];return this},r.prototype.trigger=function(t){var r,n,i,s,f,a,c=[],p=!0;if(!(r=this.__events))return this;for(t=t.split(o),f=1,a=arguments.length;a>f;f++)c[f-1]=arguments[f];for(;n=t.shift();)(i=r.all)&&(i=i.slice()),(s=r[n])&&(s=s.slice()),p=e(s,c,this)&&p,p=e(i,[n].concat(c),this)&&p;return p},r.prototype.emit=r.prototype.trigger,r.mixTo=function(t){t=n(t)?t.prototype:t;var e=r.prototype;for(var o in e)e.hasOwnProperty(o)&&(t[o]=e[o])};var i=Object.keys;return i||(i=function(t){var r=[];for(var e in t)t.hasOwnProperty(e)&&r.push(e);return r}),t.Events=r}(window);