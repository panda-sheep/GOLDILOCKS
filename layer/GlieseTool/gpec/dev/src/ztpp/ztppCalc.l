/*******************************************************************************
 * ztppCalc.l
 *
 * Copyright (c) 2011, SUNJESOFT Inc.
 *
 *
 * IDENTIFICATION & REVISION
 *        $Id$
 *
 * NOTES
 *  reference : http://c.comsci.us/etymology/lexicon.html
 *  reference : ISO/IEC 9899:1999
 *
 ******************************************************************************/

%{
#include <stl.h>
#include <goldilocks.h>
#include <sqlext.h>
#include <ztpDef.h>
#include <ztppCommon.h>
#include <ztppCalc.tab.h>
#include <ztppCalcFunc.h>
#include <ztpMisc.h>

#ifndef ZTP_PARSER_PRINT
#define ZTP_PP_PARSE_PRINT  stlIgnorePrintf
//#define ZTP_PP_PARSE_PRINT  stlPrintf
#else
#define ZTP_PP_PARSE_PRINT  stlPrintf
#endif

#define ZTP_PP_CALC_PARAM yyget_extra( yyscanner )

#define ZTP_PP_PARSE_IGNORE_STR( param )        \
    {                                           \
        *yylloc = ZTP_PP_CALC_PARAM->mCurrLoc;  \
    }

#define ZTP_PP_PARSE_RETURN_STR( aStr )                         \
    {                                                           \
        if(stlAllocRegionMem(ZTP_PP_CALC_PARAM->mAllocator,     \
                             stlStrlen(aStr) + 1,               \
                             yylval,                            \
                             ZTP_PP_CALC_PARAM->mErrorStack)    \
           != STL_SUCCESS)                                      \
        {                                                       \
            ZTP_PP_CALC_PARAM->mErrorStatus = STL_FAILURE;      \
        }                                                       \
        else                                                    \
        {                                                       \
            stlMemcpy(*yylval, aStr, stlStrlen(aStr) + 1);      \
        }                                                       \
    }

#define YY_INPUT( buffer, res, max_size )                               \
    do {                                                                \
        stlInt32  sNumBytesToRead = max_size;                           \
        stlInt32  sBytesRemain;                                         \
        sBytesRemain = ZTP_PP_CALC_PARAM->mExprLength - ZTP_PP_CALC_PARAM->mPosition; \
        if(sNumBytesToRead > sBytesRemain)                              \
        {                                                               \
            sNumBytesToRead = sBytesRemain;                             \
        }                                                               \
        stlMemcpy(buffer,                                               \
                  ZTP_PP_CALC_PARAM->mBuffer + ZTP_PP_CALC_PARAM->mPosition, \
                  sNumBytesToRead);                                     \
        res = sNumBytesToRead;                                          \
        ZTP_PP_CALC_PARAM->mPosition += sNumBytesToRead;                \
    } while (0)

#define YY_USER_ACTION                                                  \
    {                                                                   \
        stlChar * sStr;                                                 \
        if(yylineno != ZTP_PP_CALC_PARAM->mLineNo)                      \
        {                                                               \
            ZTP_PP_CALC_PARAM->mColumn = 1;                             \
            ZTP_PP_CALC_PARAM->mLength = 0;                             \
            sStr = ZTP_PP_CALC_PARAM->mBuffer + ZTP_PP_CALC_PARAM->mNextLoc \
                + yyleng - 1;                                           \
            while(*sStr != '\n')                                        \
            {                                                           \
                ZTP_PP_CALC_PARAM->mLength++;                           \
                sStr--;                                                 \
            }                                                           \
            ZTP_PP_CALC_PARAM->mLength++;                               \
        }                                                               \
        else                                                            \
        {                                                               \
            ZTP_PP_CALC_PARAM->mColumn += ZTP_PP_CALC_PARAM->mLength;   \
            ZTP_PP_CALC_PARAM->mLength  = yyleng;                       \
        }                                                               \
        ZTP_PP_CALC_PARAM->mLineNo  = yylineno;                         \
        ZTP_PP_CALC_PARAM->mCurrLoc = ZTP_PP_CALC_PARAM->mNextLoc;      \
        ZTP_PP_CALC_PARAM->mNextLoc += yyleng;                          \
        *yylloc = ZTP_PP_CALC_PARAM->mCurrLoc;                          \
    }
%}


%option reentrant noyywrap never-interactive nounistd
%option bison-bridge bison-locations
%option case-insensitive
%option nounput
%option yylineno

/* SPECIAL CHARACTER */
comment_introducer         "/*"
comment_terminator         "*/"
simple_comment             "//"[^\n]*\n
block_comment              {comment_introducer}{comment_terminator}|{comment_introducer}([^+*])([^*]|(\*+[^*/]))*\**{comment_terminator}

left_bracket               "["
right_bracket              "]"
left_paren                 "("
right_paren                ")"
left_brace                 "{"
right_brace                "}"
period                     "."
pointer_op                 "->"

double_plus                "++"
double_minus               "--"
ampersand                  "&"
asterisk                   "*"
plus                       "+"
minus                      "-"
tilde                      "~"
exclamation                "!"

solidus                    "/"
percent                    "%"
shift_left                 "<<"
shift_right                ">>"
lt                         "<"
gt                         ">"
le                         "<="
ge                         ">="
equal                      "=="
not_equal                  "!="
circumflex                 "^"
vbar                       "|"
double_ampersand           "&&"
double_vbar                "||"

question                   "?"
colon                      ":"
semicolon                  ";"
ellipsis                   "..."

assign                     "="
asterisk_assign            "*="
solidus_assign             "/="
percent_assign             "%="
plus_assign                "+="
minus_assign               "-="
shift_left_assign          "<<="
shift_right_assign         ">>="
ampersand_assign           "&="
circumflex_assign          "^="
vbar_assign                "|="

comma                      ","
sharp                      "#"
double_sharp               "##"

new_line                   "\n"
quote                      "\'"
double_quote               "\""
reverse_solidus            "\\"


/* Tokens */
/* pattern for rules */
/*
 * Preprocessor는 line단위의 작업이 이루어 지므로, space에서 new-line은
 * 따로 처리해 주도록 한다.
 * space                      [ \t\n\r\v\f]
 */
space                      [ \t\r\v\f]
whitespace                 ({space}|\\\n)+
comment                    ({simple_comment}|{block_comment})
letter                     [A-Za-z]
identifier                 [A-Za-z_][A-Za-z_0-9]*

digit                      [0-9]
non_zero_digit             [1-9]
octal_digit                [0-7]
hex_digit                  [0-9A-Fa-f]

literal                    {numeric_literal}|{string_literal}
O                          [0-7]
D                          [0-9]
NZ                         [1-9]
L                          [a-zA-Z_]
A                          [a-zA-Z_0-9]
H                          [a-fA-F0-9]
HP                         (0[xX])
E                          ([Ee][+-]?{D}+)
P                          ([Pp][+-]?{D}+)
FS                         (f|F|l|L)
IS                         (((u|U)(l|L|ll|LL)?)|((l|L|ll|LL)(u|U)?))
CP                         (u|U|L)
SP                         (u8|u|U|L)
ES                         (\\([\'\"\?\\abfnrtv]|[0-7]{1,3}|x[a-fA-F0-9]+))

hex_literal                {HP}{H}+{IS}?
decimal_literal            {NZ}{D}*{IS}?
octal_literal              "0"{O}*{IS}?
char_literal               {CP}?{quote}([^\'\\\n]|{ES})+{quote}

fixed_literal              ({decimal_literal}|{octal_literal}|{hex_literal}|{char_literal})
float_literal              ({D}+{E}|{D}*"."{D}+{E}?|{D}+"."{E}?|{HP}{H}+{P}|{HP}{H}*"."{H}+{P}|{HP}{H}+"."{P}){FS}?

numeric_literal            {fixed_literal}|{float_literal}
/*
string_literal             ({SP}?{double_quote}([^\"\\\n]|{ES})*{double_quote}{space}*)+
*/
string_literal             ({SP}?{double_quote}([^\"\\\n]|{ES})*{double_quote})({space}*{SP}?{double_quote}([^\"\\\n]|{ES})*{double_quote})*


h_string                   {lt}[^\n>]*{gt}
q_string                   {double_quote}[^\n\"]*{double_quote}

defined                    defined

%%
{new_line} {
    ZTP_PP_PARSE_PRINT("NEW_LINE: [\\n]: yylloc : %d, leng : %d\n", *yylloc, yyleng);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_NEW_LINE;
}

{whitespace} {
    ZTP_PP_PARSE_PRINT("WHITESPACE: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    //return ZTP_TOK_C_DUMMY;
}

{comment} {
    ZTP_PP_PARSE_PRINT("COMMENT: %s\n", yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    //return ZTP_TOK_C_COMMENT;
}

{h_string} {
    ZTP_PP_PARSE_PRINT("H_STRING: %s: yylloc : %d, leng : %d\n", yytext, *yylloc, yyleng);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_H_STRING;
}

{q_string} {
    ZTP_PP_PARSE_PRINT("Q_STRING: %s: yylloc : %d, leng : %d\n", yytext, *yylloc, yyleng);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_Q_STRING;
}

{literal} {
    ZTP_PP_PARSE_PRINT("LITERAL: %s: yylloc : %d, leng : %d\n", yytext, *yylloc, yyleng);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_LITERAL;
}

{double_sharp} {
    ZTP_PP_PARSE_PRINT("[##]: %s: yylloc : %d, leng : %d\n", yytext, *yylloc, yyleng);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_DOUBLE_SHARP;
}

{sharp} {
    ZTP_PP_PARSE_PRINT("[#]: %s: yylloc : %d, leng : %d\n", yytext, *yylloc, yyleng);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_SHARP;
}

{ellipsis} {
    ZTP_PP_PARSE_PRINT("[...]: %s: yylloc : %d, leng : %d\n", yytext, *yylloc, yyleng);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_ELLIPSIS;
}

{comma} {
    ZTP_PP_PARSE_PRINT("[,]: %s: yylloc : %d, leng : %d\n", yytext, *yylloc, yyleng);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_COMMA;
}

{left_paren} {
    ZTP_PP_PARSE_PRINT("[(]: %s: yylloc : %d, leng : %d\n", yytext, *yylloc, yyleng);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_LPAREN;
}

{right_paren} {
    ZTP_PP_PARSE_PRINT("[)]: %s: yylloc : %d, leng : %d\n", yytext, *yylloc, yyleng);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_RPAREN;
}

{left_bracket} {
    ZTP_PP_PARSE_PRINT("L_BRACKET: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_LBRACKET;
}

{right_bracket} {
    ZTP_PP_PARSE_PRINT("R_BRACKET: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_RBRACKET;
}

{left_brace} {
    ZTP_PP_PARSE_PRINT("L_BRACE: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_LBRACE;
}

{right_brace} {
    ZTP_PP_PARSE_PRINT("R_BRACE: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_RBRACE;
}

{period} {
    ZTP_PP_PARSE_PRINT("[.]: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_PERIOD;
}

{asterisk} {
    ZTP_PP_PARSE_PRINT("[*]: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_ASTERISK;
}

{ampersand} {
    ZTP_PP_PARSE_PRINT("[&]: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_AMPERSAND;
}

{plus} {
    ZTP_PP_PARSE_PRINT("[+]: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_PLUS;
}

{minus} {
    ZTP_PP_PARSE_PRINT("[-]: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_MINUS;
}

{tilde} {
    ZTP_PP_PARSE_PRINT("[~]: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_TILDE;
}

{exclamation} {
    ZTP_PP_PARSE_PRINT("[!]: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_EXCLAMATION;
}

{solidus} {
    ZTP_PP_PARSE_PRINT("[/]: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_SOLIDUS;
}

{percent} {
    ZTP_PP_PARSE_PRINT("[%]: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_PERCENT;
}

{lt} {
    ZTP_PP_PARSE_PRINT("[<]: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_LT;
}

{gt} {
    ZTP_PP_PARSE_PRINT("[>]: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_GT;
}

{circumflex} {
    ZTP_PP_PARSE_PRINT("CIRCUMFLEX: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_CIRCUMFLEX;
}

{vbar} {
    ZTP_PP_PARSE_PRINT("VBAR: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_VBAR;
}

{question} {
    ZTP_PP_PARSE_PRINT("QUESTION: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_QUESTION;
}

{semicolon} {
    ZTP_PP_PARSE_PRINT("SEMICOLON: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_SEMICOLON;
}

{colon} {
    ZTP_PP_PARSE_PRINT("COLON: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_COLON;
}

{assign} {
    ZTP_PP_PARSE_PRINT("ASSIGN: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_ASSIGNMENT;
}

{asterisk_assign} {
    ZTP_PP_PARSE_PRINT("*=: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_ASTERISK_ASSIGN;
}

{solidus_assign} {
    ZTP_PP_PARSE_PRINT("/=: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_SOLIDUS_ASSIGN;
}

{percent_assign} {
    ZTP_PP_PARSE_PRINT("%=: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_PERCENT_ASSIGN;
}

{plus_assign} {
    ZTP_PP_PARSE_PRINT("+=: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_PLUS_ASSIGN;
}

{minus_assign} {
    ZTP_PP_PARSE_PRINT("-=: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_MINUS_ASSIGN;
}

{shift_left_assign} {
    ZTP_PP_PARSE_PRINT("<<=: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_SL_ASSIGN;
}

{shift_right_assign} {
    ZTP_PP_PARSE_PRINT(">>=: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_SR_ASSIGN;
}

{ampersand_assign} {
    ZTP_PP_PARSE_PRINT("&=: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_AMPERSAND_ASSIGN;
}

{circumflex_assign} {
    ZTP_PP_PARSE_PRINT("^=: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_CIRCUMFLEX_ASSIGN;
}

{vbar_assign} {
    ZTP_PP_PARSE_PRINT("|=: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_VBAR_ASSIGN;
}

{shift_right} {
    ZTP_PP_PARSE_PRINT(">>: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_SR;
}

{shift_left} {
    ZTP_PP_PARSE_PRINT("<<: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_SL;
}

{double_plus} {
    ZTP_PP_PARSE_PRINT("++: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_INC;
}

{double_minus} {
    ZTP_PP_PARSE_PRINT("--: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_DEC;
}

{pointer_op} {
    ZTP_PP_PARSE_PRINT("->: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_PTR;
}

{double_ampersand} {
    ZTP_PP_PARSE_PRINT("&&: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_AND;
}

{double_vbar} {
    ZTP_PP_PARSE_PRINT("||: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_OR;
}

{le} {
    ZTP_PP_PARSE_PRINT("<=: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_LE;
}

{ge} {
    ZTP_PP_PARSE_PRINT(">=: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_GE;
}

{equal} {
    ZTP_PP_PARSE_PRINT("==: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_EQ;
}

{not_equal} {
    ZTP_PP_PARSE_PRINT("!=: yylloc : %d, leng : %d, \"%s\"\n", *yylloc, yyleng, yytext);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_SYM_NE;
}

{defined} {
    ZTP_PP_PARSE_PRINT("DEFINED: %s: yylloc : %d, leng : %d\n", yytext, *yylloc, yyleng);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_DEFINED;
}

{identifier} {
    /*
    ztpMacroSymbol   *sMacroSymbol = NULL;

    (void)ztppFindMacro( ZTP_PP_CALC_PARAM,
                         yytext,
                         &sMacroSymbol );
    if( sMacroSymbol != NULL )
    {
        ZTP_PP_PARSE_PRINT("DEFINED MACRO \"%s\": yylloc : %d, leng : %d\n", yytext, *yylloc, yyleng);

        ZTP_PP_PARSE_RETURN_STR(yytext);
        return ZTPP_TOK_DEFINED_MACRO;
    }
    else
    {
        ZTP_PP_PARSE_PRINT("IDENTIFER: %s: yylloc : %d, leng : %d\n", yytext, *yylloc, yyleng);
        ZTP_PP_PARSE_RETURN_STR(yytext);
        return ZTPP_TOK_ID;
    }
    */
    ZTP_PP_PARSE_PRINT("IDENTIFER: %s: yylloc : %d, leng : %d\n", yytext, *yylloc, yyleng);
    ZTP_PP_PARSE_RETURN_STR(yytext);
    return ZTPP_TOK_ID;
}

%%
