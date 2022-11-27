# Create your grading script here

# set -e // dont run errors

echo "Grading Script"
echo "URL: $1"

rm -rf student-submission
git clone $1 student-submission

if [$? -eq 0] 
then 
    echo "Successfully Cloned"
else 
    echo "Clone failed"
    exit 1
fi

cd student-submission

if [-e "ListExamples.java"]
then
    echo "Correct file found"
else 
    echo "Wrong file submitted"
    exit 1
fi

CP = ".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar"
cp ../TestListExample.java /student-submission
javac -cp $CP *.java 2 > compilation_error.txt
Message = `cat compilation_error.txt | head -1`

if [$? -eq 0]
then 
    echo "compilation succeed"
else 
    echo "compilation failed. ($Message)"
    exit 1
fi

rm -rf test_result.txt
java -cp $CP org.junit.runner.JUnitCore TestListExamples > test_result.txt

if [$? -eq 0]
then 
    result_pass = `cat test_result.txt | grep "OK" `
    echo "[TESTS PASSED] JUnit result: " $result_pass
else 
    result_fail = `cat test_result.txt | grep "Tests run:" `
    echo "[TESTS FAILED] JUnit result: " $result_fail
    exit 1
fi