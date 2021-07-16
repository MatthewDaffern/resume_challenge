function reqListener () {
    var obj = JSON.parse(this.responseText)
    var listItem = document.querySelector('.counter')
    var newItem = document.createElement('div')
    newItem.innerText = 'People who have seen my resume:  ' + obj.Item.count_total
    listItem.parentNode.replaceChild(newItem, listItem)
    return obj
  }


var oReq = new XMLHttpRequest();
oReq.addEventListener("load", reqListener);
oReq.open("GET", "https://mvpttsd3he.execute-api.us-west-2.amazonaws.com/stage/updateCount");
oReq.send()