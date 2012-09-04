parser grammar P;

options {
  language = Java;
  tokenVocab = L;
  output=AST;
}

block
  : LBRACE statement* RBRACE EOF 
  ;

statement
  : LOG_STATEMENT_TOKEN expression SEMICOLON
  | expression SEMICOLON
  ;

expression
  : multExpr
  ;
  
multExpr
  : primaryExpr ( DEVIDE_EXPR primaryExpr )?
  ;
  
primaryExpr
  : IDENT ( DOT_EXPR IDENT ( LPAREN argExpr? RPAREN )? )*
  | DOUBLE_QUOTED
  | SINGLE_QUOTED
  | INTEGER_LITERAL
  | NUMBER_LITERAL
  | REGEXP_LITERAL
  ;

argExpr
  : expression ( COMMA expression )*
  ;

