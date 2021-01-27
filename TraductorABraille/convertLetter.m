function [lettre]=convertLetter(n)
switch n
    case 1
        lettre='A';
    case 2
        lettre='B';
    case 3
        lettre='C';
    case 4
        lettre='D';
    case 5
        lettre='E';
    case 6
        lettre='F';
    case 7
        lettre='G';
    case 8
        lettre='H';
    case 9
        lettre='I';
    case 10
        lettre='J';
    case 11
        lettre='K';
    case 12
        lettre='L';
    case 13
        lettre='M';
    case 14
        lettre='N';
    case 15
        lettre='O';
    case 16
        lettre='P';
    case 17
        lettre='Q';
    case 18
        lettre='R';
    case 19
        lettre='S';
    case 20
        lettre='T';
    case 21
        lettre='U';
    case 22
        lettre='V';
    case 23
        lettre='W';
    case 24
        lettre='X';
    case 25
        lettre='Y';
    case 26
        lettre='Z';
    case 27
        lettre='.';
    case 28
        lettre=',';
    case 29
        lettre='''';
    case 30
        lettre='-';
    case 33
        lettre='?';
    case 34
        lettre='!';
    case 35
        lettre=';';
    otherwise
        lettre='&&';
end