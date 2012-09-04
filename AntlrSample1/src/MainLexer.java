import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;

import org.antlr.runtime.*;
 
public class MainLexer {
	public static void main(String[] args) {
		String[] tests = {
			"hoge.fuga",
			"/hoge/.func('hoge hoge')/2",
			"3/2",
			"hoge/2",
			"3//hoge/",
			"/* hoge */",
			"3/ /hoge/",
			"log hoge;",
			"console.log('hoge');",
			"log hoge;console.log('hoge');",
			"{ log hoge; console.log('hoge');/hoge/g;3 / 2;}"
		};
		ArrayList<String> list = getTokenList();
		for( int i = 0; i < tests.length; ++i ) {
			String test = tests[i];
			System.out.println("TEST: "+test);
			try {
				CharStream input = new ANTLRStringStream(test);
				L lexer = new L();
				lexer.setCharStream(input);
				Token token;
				while ( true ) {
					token = lexer.nextToken();
					if( token.getType() == Token.EOF ) break;
					System.out.println("Token: "+token.getText() + "("+list.get(token.getType())+")");
				}
			} catch(Throwable t) {
				System.out.println("Exception: "+t);
				t.printStackTrace();
			}
			System.out.println();
		}
	}

	private static ArrayList<String> getTokenList() {
		ArrayList<String> list = new ArrayList<String>();
		try {
			FileReader f = new FileReader("src/L.tokens");
			BufferedReader b = new BufferedReader(f);
			String s;
			while((s = b.readLine())!=null){
				String[] ary = s.split("=");
				int idx = Integer.parseInt(ary[1]);
				String val = ary[0];
				if( list.size() <= idx) {
			 		while ( list.size() <= idx) {
			 			list.add("");
			 		}
				}
				list.set( idx, val );
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
}