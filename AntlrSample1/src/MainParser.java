import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.CharStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
import org.antlr.runtime.tree.Tree;

public class MainParser {

	/**
	 * @param args
	 * @throws RecognitionException 
	 */
	public static void main(String[] args) throws RecognitionException {
		CharStream input = new ANTLRStringStream("{ log hoge; console.log('hoge');/hoge/g;3 / 2;}");
		L lexer = new L(input);
		CommonTokenStream tokenStream = new CommonTokenStream( lexer );
		P parser = new P( tokenStream );
		P.block_return root = parser.block();
		System.out.println("tree="+((Tree)root.tree).toStringTree());
		System.out.println("ok");
	}

}
