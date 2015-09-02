var readline = require('readline');
reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback) {
  if (numsLeft > 0) {
    reader.question("Enter a number: ", function(numString) {
      var num = parseInt(numString);
      sum += num;
      console.log("Your current sum is: " + sum);
      console.log("You have " + (numsLeft - 1) + " inputs left")
      addNumbers(sum, numsLeft - 1, completionCallback);
    });
  } else {
    completionCallback(sum);
    reader.close();
  }

}

addNumbers(0, 3, function (sum) {
  console.log("Total Sum: " + sum);
});
