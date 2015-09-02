var Cat = function (name, owner) {
  this.name = name;
  this.owner = owner;

}

Cat.prototype.cuteStatement = function () {
  return this.owner + " loves " + this.name;
}

cat1 = new Cat("Little", "Irene");
console.log(cat1.cuteStatement());

Cat.prototype.cuteStatement = function () {
  return "Everyone loves " + this.name;
}

console.log(cat1.cuteStatement());

Cat.prototype.meow = function () {
  return "meow"
}

console.log(cat1.meow());

cat1.meow = function() {
  return "purrs"
}

cat2 = new Cat("Big", "Irene");
console.log(cat1.meow());
console.log(cat2.meow());
