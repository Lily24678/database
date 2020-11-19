package com.lsy.code.xml;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;
/**
 * JavaSE API 解析xml
 */
public class XMLParseUtils {
    // 根据XML文件路径获得Document对象
    public static Document getXmlDocument(String xmlPath) throws Exception {
        DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();

        documentBuilderFactory.setValidating(true);                         // 是否指定此代码生成的解析器将在文档解析时验证文档
        documentBuilderFactory.setNamespaceAware(false);                    // 是否指定此代码生成的解析器将为XML命名空间提供支持
        documentBuilderFactory.setIgnoringComments(true);                   // 是否指定此代码生成的解析器将忽略注释
        documentBuilderFactory.setIgnoringElementContentWhitespace(false);  // 是否指定此工厂创建的解析器必须在解析XML文档时消除元素内容中的空格（有时称为“可忽略的空白”）
        documentBuilderFactory.setCoalescing(false);                        // 是否指定此代码生成的解析器将CDATA节点转换为文本节点并将其附加到相邻（如果有的话）文本节点
        documentBuilderFactory.setExpandEntityReferences(true);             // 是否指定此代码生成的解析器将扩展实体引用节点

        // 创建DocumentBuilder
        DocumentBuilder builder = documentBuilderFactory.newDocumentBuilder();
        // 设置异常处理对象
        builder.setErrorHandler(new ErrorHandler() {

            @Override
            public void warning(SAXParseException exception) throws SAXException {
                // TODO Auto-generated method stub
            }

            @Override
            public void fatalError(SAXParseException exception) throws SAXException {
                // TODO Auto-generated method stub
            }

            @Override
            public void error(SAXParseException exception) throws SAXException {
                // TODO Auto-generated method stub
            }
        });
        return builder.parse(xmlPath);
    }


        public static void main(String[] args) throws Exception {
            Document doc = XMLParseUtils.getXmlDocument("src/main/resources/xml/demo.xml");

            // 创建 XPathFactory
            XPathFactory factory = XPathFactory.newInstance();
            // 创建 XPath对象
            XPath xpath = factory.newXPath();
            // 编译 XPath表达式
            // 表达式字符串定义了获取节点的规则
            XPathExpression expr = xpath.compile("//作者/text()");

            // 通过XPath表达式得到结果，第一个参数指定了XPath表达式进行查询的上下文节点，也就是在指定节点下查找符合XPath的节点
            // 本例中的上下文节点时整个文档；第二个参数指定了XPath表达式的返回类型
            Object result = expr.evaluate(doc, XPathConstants.NODESET);
            NodeList nodes = (NodeList) result;   // 强制类型转换，至于转换后的类型要看XPathExpression.evaluate方法returnType的设置
            for (int i = 0; i < nodes.getLength(); i++) {
                System.out.println(nodes.item(i).getNodeValue());
            }
        }
}
