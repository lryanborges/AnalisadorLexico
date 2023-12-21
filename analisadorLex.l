%{
#include <iostream>
#include <cstdio>
#include <string>
#include <unordered_map>
using std::cout;
using std::cin;
using std::string;
enum {SOME = 1, ALL, VALUE, MIN, MAX, EXACTLY, THAT, NOT, AND, OR, ONLY, RWORD, CLASS, PROPRIETY, INSTANCY, SSYMBOL, DTYPE, CARDINALIDADE};
%}

%option noyywrap

maiusc [A-Z]
minusc [a-z]
digito [0-9]

%%
[ \t\n]+                                            ; 
[+-]?(({digito}+)|({digito}*\.{digito}+)([eE][-+]?{digito}+)?)      return CARDINALIDADE;
(some)                                                              return SOME;
(all)                                                               return ALL;
(value)                                                             return VALUE;
(min)                                                               return MIN;
(max)                                                               return MAX;
(exactly)                                                           return EXACTLY;
(that)                                                              return THAT;
(not)                                                               return NOT;
(and)                                                               return AND;
(or)                                                                return OR;
(only)                                                              return ONLY;
({maiusc})({minusc}+)(_?({maiusc})({minusc}+))*:                    return RWORD;
({maiusc})({minusc}+)(_?({maiusc})({minusc}+))*                     return CLASS;
((has)(({maiusc})({minusc}+))+)|((is)({maiusc})({minusc}+)(Of))     return PROPRIETY;
(({minusc}+)(({maiusc})({minusc})*)*)                               return PROPRIETY;
({maiusc})({minusc}+)(_?({maiusc})({minusc}+))*({digito}*)          return INSTANCY;
"["                                                                 return SSYMBOL;
"]"                                                                 return SSYMBOL;
"{"                                                                 return SSYMBOL;
"}"                                                                 return SSYMBOL;
"("                                                                 return SSYMBOL;
")"                                                                 return SSYMBOL;
">"                                                                 return SSYMBOL;
"<"                                                                 return SSYMBOL;
"="                                                                 return SSYMBOL;
"<="                                                                return SSYMBOL;
">="                                                                return SSYMBOL;
","                                                                 return SSYMBOL;
(({minusc}+):" "?({minusc}+))                                       return DTYPE;


%%

int main()
{
    yyFlexLexer lexer;
    int lookahead;
    int option;

    std::unordered_map <string, int> lexemas;

    int rword = 0;
    int cardinalidade = 0;
    int classe = 0;
    int propriety = 0;
    int instancy = 0;
    int ssymbol = 0;
    int dtype = 0;

    
    cout << "\n======= Análise léxica =======\n";

    // enquanto não atingir o fim da entrada
    while ((lookahead = lexer.yylex()) != 0)
    {
        // trata o token recebido do analisador léxico
        switch(lookahead)
        {
            case SOME: rword++; lexemas.insert({lexer.YYText(), RWORD}); break;
            case ALL: rword++; lexemas.insert({lexer.YYText(), RWORD}); break;
            case VALUE: rword++; lexemas.insert({lexer.YYText(), RWORD}); break;
            case MIN: rword++; lexemas.insert({lexer.YYText(), RWORD}); break;
            case MAX: rword++; lexemas.insert({lexer.YYText(), RWORD}); break;
            case EXACTLY: rword++; lexemas.insert({lexer.YYText(), RWORD}); break;
            case THAT: rword++; lexemas.insert({lexer.YYText(), RWORD}); break;
            case NOT: rword++; lexemas.insert({lexer.YYText(), RWORD}); break;
            case AND: rword++; lexemas.insert({lexer.YYText(), RWORD}); break;
            case OR: rword++; lexemas.insert({lexer.YYText(), RWORD}); break;
            case ONLY: rword++; lexemas.insert({lexer.YYText(), RWORD}); break;
            case RWORD: rword++; lexemas.insert({lexer.YYText(), RWORD}); break;
            case CLASS: classe++; lexemas.insert({lexer.YYText(), CLASS}); break;
            case PROPRIETY: propriety++; lexemas.insert({lexer.YYText(), PROPRIETY}); break;
            case INSTANCY: instancy++; lexemas.insert({lexer.YYText(), INSTANCY}); break;
            case SSYMBOL: ssymbol++; lexemas.insert({lexer.YYText(), SSYMBOL}); break;
            case DTYPE: dtype++; lexemas.insert({lexer.YYText(), DTYPE}); break;
            case CARDINALIDADE: cardinalidade++; lexemas.insert({lexer.YYText(), CARDINALIDADE}); break;
        }
    }

    // isso aqui faz com que o cin e o cout saiam do domínio do flex e venham pro meu buffer
    freopen("/dev/tty", "r", stdin);
    freopen("/dev/tty", "w", stdout);

    do {
    cout << "---------------------------------------" << std::endl;
    cout << "Escolha uma opção:\n" << 
    "1 - Mostrar somentes os tokens\n" <<
    "2 - Mostrar tokens e sua quantidade\n" <<
    "3 - Mostrar tokens e lexemas\n" <<
    "4 - Mais opções\n" <<
    "5 - Sair\n";
    cout << "---------------------------------------" << std::endl;
    cout << "Opção: ";

    cin >> option;

    switch(option){
        case 1: 
            cout << "- RWORD: Palavra reservada\n";
            cout << "- CLASS: Classe\n";
            cout << "- PROPRIETY: Propriedade\n";
            cout << "- INSTANCY: Instância/Indivíduo\n";
            cout << "- SSYMBOL: Símbolo especial\n";
            cout << "- DTYPE: Tipo de dado\n";
            cout << "- CARDINALIDADE: Cardinalidade\n";
        break;
        case 2: 
            cout << "---------------------------------------" << std::endl;
            cout << "RWORD: " << rword << std::endl;
            cout << "CLASS: " << classe << std::endl;
            cout << "PROPRIETY " << propriety << std::endl;
            cout << "INSTANCY: " << instancy << std::endl;
            cout << "SSYMBOL: " << ssymbol << std::endl;
            cout << "DTYPE: " << dtype << std::endl;
            cout << "CARDINALIDADE: " << cardinalidade << std::endl;
            cout << "---------------------------------------" << std::endl;
        break;
        case 3: 
            for (auto itr = lexemas.begin(); itr != lexemas.end(); ++itr) {
                cout << " - Lexema: " << itr->first << ", ";

                if(itr->second <= 12){
                    cout << "Token: RWORD" << std::endl;
                }

                switch(itr->second) {
                    case 13: cout << "Token: CLASS" << std::endl; break;
                    case 14: cout << "Token: PROPRIETY" << std::endl; break;
                    case 15: cout << "Token: INSTANCY" << std::endl; break;
                    case 16: cout << "Token: SSYMBOL" << std::endl; break;
                    case 17: cout << "Token: DTYPE" << std::endl; break;
                    case 18: cout << "Token: CARDINALIDADE" << std::endl; break;
                }
            }
        break;
        case 4:

            cout << "Buscar por:\n" <<
            "1 - Classes\n" <<
            "2 - Propriedades\n" <<
            "3 - Tipos de dados\n" <<
            "4 - Instâncias\n" <<
            "5 - Símbolos especiais\n" <<
            "6 - Cardinalidades\n" <<
            "7 - Palavras reservadas\n" <<
            "8 - Sair\n" <<
            "Opção: ";

            int opt;
            cin >> opt;
            cout << "---------------------------------------" << std::endl;

            switch(opt){
                case 1: 
                cout << "Classes:\n";
                for(auto iterator = lexemas.begin(); iterator != lexemas.end(); ++iterator){
                    if(iterator->second == CLASS){
                        cout << iterator->first << std::endl;
                    }
                }
                
                break;
                case 2: 
                cout << "Propriedades:\n";
                for(auto iterator = lexemas.begin(); iterator != lexemas.end(); ++iterator){
                    if(iterator->second == PROPRIETY){
                        cout << iterator->first << std::endl;
                    }
                }
                
                break;
                case 3: 
                cout << "Tipos de dados:\n";
                for(auto iterator = lexemas.begin(); iterator != lexemas.end(); ++iterator){
                    if(iterator->second == DTYPE){
                        cout << iterator->first << std::endl;
                    }
                }
                
                break;
                case 4: 
                cout << "Instâncias:\n";
                for(auto iterator = lexemas.begin(); iterator != lexemas.end(); ++iterator){
                    if(iterator->second == INSTANCY){
                        cout << iterator->first << std::endl;
                    }
                }
                
                break;
                case 5: 
                cout << "Símbolos especiais:\n";
                for(auto iterator = lexemas.begin(); iterator != lexemas.end(); ++iterator){
                    if(iterator->second == SSYMBOL){
                        cout << iterator->first << std::endl;
                    }
                }
                
                break;
                case 6: 
                cout << "Cardinalidades:\n";
                for(auto iterator = lexemas.begin(); iterator != lexemas.end(); ++iterator){
                    if(iterator->second == CARDINALIDADE){
                        cout << iterator->first << std::endl;
                    }
                }
                
                break;
                case 7:
                cout << "Palavras reservadas:\n";
                for(auto iterator = lexemas.begin(); iterator != lexemas.end(); ++iterator){
                    if(iterator->second == RWORD){
                        cout << iterator->first << std::endl;
                    }
                }
                
                break;
                case 8: break;
                default: cout << "Opção inválida.\n"; break;
            }

        break;
        case 5: break;
        default: cout << "Opção inválida" << std::endl;
    }
    } while(option != 5);

}