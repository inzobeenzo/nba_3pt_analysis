function palindrome(word) {
    var str = '';
    for (let s of word) {
        if(s !== ' ') {
            str += s;
        }
    }

    str = str.toLowerCase();
    var j = str.length -1;

    for(let i = 0; i < str.length; i++) {
        if(str[i] != str[j]) {
            return false;
            break;
        }
        j--;
    }
    return true;
}

console.log(palindrome("racecar"));      
console.log(palindrome("race car"));      
console.log(palindrome("hello"));        
console.log(palindrome("A man, a plan, a canal: Panama"));
console.log(palindrome("race car"));
console.log(palindrome("Was it a car or a cat I saw?"));