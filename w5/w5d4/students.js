function Student(fname, lname) {
  this.name = fname + " " + lname;
  this.courses = [];
  this.enroll = function (course) {
    var unique = true;
    for (var i = 0; i < this.courses.length; i++) {
      if (this.courses[i] === course) {
        unique = false;
      }
    }
    if (unique) {
      this.courses.push(course);
    }
  }
  this.courseLoad = function () {
    var courseAndLoads = {};
    this.courses.forEach( function (course) {
      if (courseAndLoads[course.department]) {
        courseAndLoads[course.department] += course.units;
      } else {
        courseAndLoads[course.department] = course.units;
      }
    })

    return courseAndLoads;
  }
}


function Course(courseName, department, units) {
  this.courseName = courseName;
  this.department = department;
  this.units = units;
  this.students = [];
  this.add_student = function (student) {
    student.enroll(this);
    this.students.push(student);
  }
}

student1 = new Student("Bob", "AlmostOver");
course1 = new Course("English", "No mas", 3);
course1.add_student(student1);

console.log(student1.courseLoad());
console.log(course1.students);
