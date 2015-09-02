Function.prototype.inherits = function(ChildClass, ParentClass) {
  function Surrogate() {};
  Surrogate.prototype = ParentClass.prototype;
  ChildClass.prototype = new Surrogate();
  ChildClass.prototype.constructor = ChildClass;
};

function Animal(name) {
  this.name = name;
}


function Cat(name, owner) {
  Animal.call(this, name);
  this.owner = owner;
}

Function.prototype.inherits(Cat, Animal);
c = new Cat("gizmo", "ned");

Animal.prototype.hello = function() {
  console.log("hello, I'm " + this.name);
}

c.hello();

Cat.prototype.meow = function() {
  console.log("meow meow");
};
