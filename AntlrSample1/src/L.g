lexer grammar L;

options {
  language = Java;
}

@members {
  Boolean calcFlg = false ; // for regexp / divide
  Boolean isStatement = false; // for log statement / ident
}

SEMICOLON
  : ';' 
    {
      calcFlg = false;
      isStatement = true;
    } // reset
  ;

LOG_STATEMENT_TOKEN
  : {isStatement}?=> 'log'
  ;

LBRACE
  : '{' { isStatement = true; }
  ;

RBRACE
  : '}'
  ;

LPAREN
  : '('
  ;

RPAREN
  : ')'
  ;

COMMA
  : ','
  ;

DOT_EXPR
  : '.' {isStatement = false;}
  ;

DEVIDE_EXPR
  : {calcFlg}?=> '/' { calcFlg = false; }
  ;

MULTILINE_COMMENT
  : '/*' ( options {greedy=false;} : . )* '*/' {$channel=HIDDEN;}
  ;

SIGLELINE_COMMENT
  : '//' ~('\n'|'\r')* '\r'? ('\n'|EOF) {$channel=HIDDEN;}
  ;

fragment
CHAR_EXCLUDE_DOUBLE_QUOTED_SPECIAL
  : ~('"' | '\\')
  ;

fragment
DOUBLE_QUOTED_CHARS
  : CHAR_EXCLUDE_DOUBLE_QUOTED_SPECIAL* ('\\' . CHAR_EXCLUDE_DOUBLE_QUOTED_SPECIAL*)*
  ;

DOUBLE_QUOTED
  : '"' DOUBLE_QUOTED_CHARS  '"'
  ;

fragment
CHAR_EXCLUDE_SINGLE_QUOTED_SPECIAL
  : ~('\'' | '\\')
  ;

fragment
SINGLE_QUOTED_CHARS
  : CHAR_EXCLUDE_SINGLE_QUOTED_SPECIAL* ('\\' . CHAR_EXCLUDE_SINGLE_QUOTED_SPECIAL*)*
  ;

SINGLE_QUOTED
  : '\'' SINGLE_QUOTED_CHARS '\''
  ;


fragment
CHAR_EXCLUDE_REGEXP_SPECIAL
  : ~('/' | '\\')
  ;

fragment
REGEXP_CHARS
  : CHAR_EXCLUDE_REGEXP_SPECIAL* ('\\' . CHAR_EXCLUDE_REGEXP_SPECIAL*)*
  ;

REGEXP_LITERAL
  : {!calcFlg}?=> '/' ~'*' REGEXP_CHARS '/' ('m' | 'g' | 'i')*
  ;

fragment
DECIMAL_INTEGER_LITERAL
  : '0'
  | ('1'..'9') ('0'..'9')*
  ;

fragment
EXPONENT_PART
  : ('e' | 'E') ('+' | '-')? ('0'..'9')+
  ;

NUMBER_LITERAL
  : ( DECIMAL_INTEGER_LITERAL( '.' ('0'..'9')*)? EXPONENT_PART?
    | '.' ('0'..'9')+ EXPONENT_PART?
    | 'NaN'
    | 'Infinity'
    ) { calcFlg = true; }
  ;

INTEGER_LITERAL
  : ( '0' ('x' | 'X') ('0' .. '9' | 'a' .. 'f' | 'A' .. 'F')+ 
    | DECIMAL_INTEGER_LITERAL
    ) { calcFlg = true; }
  ;

IDENT
  : ('a'..'z' | 'A'..'Z' | '_') ('a'..'z' | 'A'..'Z' | '_' | '0'..'9')* { calcFlg = true; }
  ;

WS
  : (' ' | '\r' | '\t' | '\u000C' | '\n') {$channel=HIDDEN;}
  ;
