function Clock () {
    this.current_time = new Date();
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  // seconds = this.current_time * 1000;
  hours = this.current_time.getHours();
  min = this.current_time.getMinutes();
  sec = this.current_time.getSeconds();
  console.log(hours + ":" + min + ":" + sec)

  // Format the time in HH:MM:SS
};

Clock.prototype.run = function () {
  this.printTime();
  // setInterval(this._tick, Clock.TICK);
  setInterval(function(callback){
    this._tick();
  }.bind(this), Clock.TICK);
  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
};

Clock.prototype._tick = function () {
  this.current_time.setSeconds(this.current_time.getSeconds() + (Clock.TICK/1000));
  this.printTime();
  // 1. Increment the currentTime.
  // 2. Call printTime.
};

var clock = new Clock();
clock.run();
