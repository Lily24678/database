package com.lsy.code.xml;

import com.lsy.code.utils.StringUtil;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;
import org.junit.Test;

import javax.xml.soap.Node;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

public class Dom4j1 {
	private static Logger logger = Logger.getLogger("com.lsy.code.xml.Dom4j1");
	
	/**
	 * 解析xml文档
	 * @throws Exception
	 */
	@Test
	public void test1_parseDoc() throws Exception {
		// 获取文档对象
		Document document = Dom4jUtil.getDocument("xml/demo.xml");
		logger.info(document.asXML());
		//操作文档对象:遍历打印节点内容
		Element root = document.getRootElement();
		Dom4jUtil.operate_iterate_print(root);
		//操作文档对象：使用XPath表达式解析
		operate_iterate_print_withXPth(document);
	}

	/**
	 * 向xml文档写入
	 * @throws IOException 
	 */
	@Test
	public void test2_wreDoc() throws IOException{
		//创建文档节点对象
		Document document=createDocument();
		//ml格式化输出
		OutputFormat format = OutputFormat.createPrettyPrint();
		//解决格式化写入时的异常：String index out of range: -1
		format.setPadText(false);
		XMLWriter writer = new XMLWriter(System.out,format);
		writer.write(document);
		writer.close();

	}

	/**
	 * 创建文档节点对象
	 * @return
	 */
	private Document createDocument() {
		//创建新文档节点对象
		Document document = DocumentHelper.createDocument();
		//向文档节点对象中添加元素节点
		Element rootELement = document.addElement("书");
		rootELement.addAttribute("类型", "历史");
		rootELement.addText("");
		//向指定元素节点添加子元素节点
		Dom4jUtil.addSubELment(rootELement,"作者","","","罗贯中");
		//向指定元素节点添加子元素节点
		Dom4jUtil.addSubELment(rootELement,"售价","","","50.00￥");
		return document;
	}




	/**
	 * 操作文档节点对象：使用XPath表达式解析
	 * @param document
	 */
	private void operate_iterate_print_withXPth(Document document) {
		List<Node> nodes = document.selectNodes("//作者");
		for (int i = 0; i < nodes.size(); i++) {
			Element element = (Element) nodes.get(i);
			System.out.println(element.getText());
		}
	}





}
