var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


function Hanoi() {
    this.tower1 = [1, 2, 3, 4, 5, 6, 7, 8];
    this.tower2 = [];
    this.tower3 = [];
}

Hanoi.prototype.isWon = function() {
  if (this.tower1.length === 0 && (this.tower2.length === 0 || this.tower3.length === 0)){
    return true;
  } else {
    return false;
  }
}

Hanoi.prototype.isValidMove = function(startTowerIdx, endTowerIdx){
  if (endTowerIdx.length == 0 || startTowerIdx[startTowerIdx.length - 1] < endTowerIdx[endTowerIdx.length - 1]) {
    return true;
  } else {
    return false;
  }
}

Hanoi.prototype.getTower = function(toweridx) {
  if (toweridx == 1) {
    return this.tower1;
  } else if (toweridx == 2) {
    return this.tower2;
  } else {
    return this.tower3;
  }
}

Hanoi.prototype.move = function(startTowerIdx, endTowerIdx, completionCallback) {
  // console.log("here");
  startvalue = this.getTower(startTowerIdx);
  endvalue = this.getTower(endTowerIdx);

  if (this.isValidMove(startvalue, endvalue)) {
    endvalue.push(startvalue.pop());
  } else {
    console.log("Invalid Move")
  }
  this.run(completionCallback)

}

Hanoi.prototype.print = function() {
  console.log("Tower1: " + JSON.stringify(this.tower1));
  console.log("Tower2: " + JSON.stringify(this.tower2));
  console.log("Tower3: " + JSON.stringify(this.tower3));
}

Hanoi.prototype.promptMove = function(callback, completionCallback){
  this.print();
  reader.question("Select tower to move from: ", function(startString) {
    reader.question("Select tower to move to: ", function(endString) {
        var start = parseInt(startString);
        var end = parseInt(endString);
          callback(start, end, completionCallback);
    });
  });

}

Hanoi.prototype.run = function(completionCallback){

    if (this.isWon()) {
      completionCallback();
    } else {
      this.promptMove(this.move.bind(this), completionCallback)
    }
  }


var hanoi = new Hanoi();
hanoi.run(function() {
  console.log("You Win");
  reader.close();
});
