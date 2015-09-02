var Board = require("./board.js");

var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});



function Game() {
  this.board = new Board();
  this.player = "x"
}

Game.prototype.run = function (completionCallback) {
  if (this.isWon()) {
    completionCallback();
  } else {
    this.change_player();
    this.promptMove(this.move.bind(this), completionCallback)
  }
}

Game.prototype.change_player = function() {
  if (this.player == "x") {
    this.player = "o";
  } else {
    this.player = "x";
  }
}

Game.prototype.promptMove = function(callback, completionCallback){
  this.board.print();
  reader.question("Select spot to move to: ex 0,1", function(placeString) {
      callback(placeString, completionCallback);
  });
}

Game.prototype.isValidMove = function(move_spot) {
  if ((move_spot[0] <= 2 && move_spot[0] >= 0) && (move_spot[1] <= 2 && move_spot[1] >= 0) &&
    (this.board.grid[move_spot[0]][move_spot[1]] == null)) {
    return true;
  } else {
    return false;
  }
}

Game.prototype.move = function(placeString, completionCallback) {
  var move_spot = placeString.split(",").map(function(el){
    return parseInt(el);
  });

  if (this.isValidMove(move_spot)) {
    this.board.grid[move_spot[0]][move_spot[1]] = this.player
  } else {
    console.log("Invalid Move")
  }
  this.run(completionCallback)
}


Game.prototype.isWon = function() {
  var winner = false;
  var diagonal1 = [this.board.grid[0][0], this.board.grid[1][1], this.board.grid[2][2]];
  var diagonal2 = [this.board.grid[0][2], this.board.grid[1][1], this.board.grid[2][0]];
  this.board.grid.forEach( function(row){
    if (JSON.stringify(row) === JSON.stringify(["x","x","x"]) ||
      JSON.stringify(row) === JSON.stringify(["o","o","o"])) {
      winner = true;
    }
  });

  this.board.grid.transpose().forEach( function(col){
    if (JSON.stringify(col) === JSON.stringify(["x","x","x"]) ||
      JSON.stringify(col) === JSON.stringify(["o","o","o"])) {
      winner = true;
    }
  });

  if (JSON.stringify(diagonal1) === JSON.stringify(["x","x","x"]) ||
      JSON.stringify(diagonal1) === JSON.stringify(["o","o","o"])) {
      winner = true;
  }

  if (JSON.stringify(diagonal2) === JSON.stringify(["x","x","x"]) ||
      JSON.stringify(diagonal2) === JSON.stringify(["o","o","o"])) {
      winner = true;
  }
  return winner;
}


Array.prototype.transpose = function () {
  var columns = [];
  for (var i = 0; i < this[0].length; i++) {
    columns.push([]);
  }

  for (var i = 0; i < this.length; i++) {
    for (var j = 0; j < this[i].length; j++) {
      columns[j].push(this[i][j]);
    }
  }
  return columns;
};

var game = new Game();
game.run(function() {
  console.log("You Win");
  reader.close();
});

module.exports = Game;
