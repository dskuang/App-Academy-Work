Function.prototype.myBind(context) {
  var fn = this;
  function callback(){
    fn.apply(context)
  }
}


// cat = {
//   talk: function() {
//     console.log("hi");
//   }
// }
//
// talk()
// cat.talk()
// new talk()
// talk.apply(cat)
// cat.talk
// a = cat.talk
// b = a.bind(cat)
