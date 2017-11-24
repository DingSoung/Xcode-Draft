function payClick() {
    window.webkit.messageHandlers.Pay.postMessage({order_no:'201511120981234',channel:'wx',amount:'1',subject:'粉色外套'});
}

