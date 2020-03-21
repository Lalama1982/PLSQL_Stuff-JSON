<?php
//examplpe URL : http://localhost:8081/PhpWebServ/displayValuesSent.php?name=Lalama&email=lalamaesp@gmail.com&gender=male&course=OCA2&class=2008&subject=PL/SQL
// Retrieve data from POST String
$name    = $_GET['name'];
$email   = $_GET['email'];
$gender  = $_GET['gender'];
$course  = $_GET['course'];
$class   = $_GET['class'];
$subject = $_GET['subject'];

$display_string = "Your name is $name";
$display_string .= " your email address is $email";
$display_string .= " your class time at $course";
$display_string .= " your class info $class";
$display_string .= " your gender is $gender";
$display_string .= " your gender is $subject";

$bus = array(
        'name' => $name,
        'email' => $email,
        'course' => $course,
        'class' => $class,
        'gender' => $gender,
        'subject' => $subject  );


header('Content-Type: application/json');
echo json_encode($bus);
?>