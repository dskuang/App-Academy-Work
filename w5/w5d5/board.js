function Board() {
  this.grid = [[null, null, null], [null, null, null], [null, null, null]];
}

Board.prototype.print = function() {
  this.grid.forEach( function(el) {
    console.log(el);
  });
}

module.exports = Board;
