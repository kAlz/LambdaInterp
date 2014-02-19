type svalue = Tokens.svalue
type pos = int
type ('a,'b) token = ('a,'b) Tokens.token
type lexresult = (svalue, pos) token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos

fun err (p1,p2) = ErrorMsg.error p1

fun eof () =
	let
	    val pos = hd (!linePos)
	in
	    Tokens.EOF (pos,pos)
	end

fun dopos token yypos yylen = token (yypos, yypos + yylen)
fun dopos3 token value yypos yylen = token (value, yypos, yypos + yylen)

%%

%header (functor LambdaLexFun (structure Tokens: Lambda_TOKENS));

id = [a-zA-Z0-9_\*]+;
whitespace=[\ \t]+;
newline=[\r\n|\n\r|\r|\n]+;

"lam"                           => (dopos Tokens.LAM yypos 3);
"."                             => (dopos Tokens.DOT yypos 1);
"let"                           => (dopos Tokens.LET yypos 3);
"in"                            => (dopos Tokens.IN yypos 2);
"("                             => (dopos Tokens.LPAREN yypos 1);
")"                             => (dopos Tokens.RPAREN yypos 1);
"="                             => (dopos Tokens.EQUALS yypos 1);
{id}                            => (dopos3 Tokens.ID yytext yypos (size yytext));
.
%%

