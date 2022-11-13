# Create your grading script here

# set -e // dont run errors

rm -rf student-submission
git clone $1 student-submission

if [-e "ListExamples.java"]
then
    echo "Correct file found"
else 
    echo "Wrong file submitted"
    exit 0
fi

cp TestListExample.java /student-submission

CP = .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar
javac -cp $CP *.java

$command 2 > file.txt
if [$? -eq 0]
then 
    echo "compilation succeed"
else 
    echo "compilation fails"
    exit 0
fi

java -cp $CP org.junit.runner.JUnitCore TestListExamples
$command > output.txt
