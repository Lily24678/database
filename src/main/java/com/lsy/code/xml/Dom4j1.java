package com.lsy.code.xml;

import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

import javax.xml.soap.Node;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.junit.Test;

import com.lsy.code.utils.StringUtil;

public class Dom4j1 {
	private static Logger logger = Logger.getLogger("com.lsy.code.xml.Dom4j1");
	
	/**
	 * 解析xml文档
	 * @throws Exception
	 */
	@Test
	public void test1_dom4j() throws Exception {
		// 获取文档对象
		Document document = getDocument("xml/demo.xml");
		logger.info(document.asXML());
		//操作文档对象:遍历打印节点内容
		Element root = document.getRootElement();
		operate_iterate_print(root);
		//操作文档对象：使用XPath表达式解析
		operate_iterate_print_withXPth(document);
	}

	/**
	 * 向xml文档写入
	 * @throws IOException 
	 */
	@Test
	public void test2_dom4j() throws IOException{
		// 获取文档对象
//		Document document = getDocument("xml/demo.xml");
//		XMLWriter writer = new XMLWriter(System.out);
//		writer.write(document);
//		writer.close();
		
		//创建文档对象
		Document document=createDocument();
		XMLWriter writer = new XMLWriter(System.out);
		writer.write(document);
		writer.close();
		
	}

	/**
	 * 创建文档对象
	 * @return
	 */
	private Document createDocument() {
		//创建文档对象
		Document document = DocumentHelper.createDocument();
		//创建根元素
		Element rootELement = document.addElement("书");
		rootELement.addAttribute("类型", "历史");
		rootELement.addText("");
		//向指定元素添加子元素
		addSubELment(rootELement,"作者","","","罗贯中");
		//向指定元素添加子元素
		addSubELment(rootELement,"售价","","","50.00￥");
		return document;
	}


	/**
	 * 向指定元素添加子元素
	 * @param parentElement
	 * @param elementName
	 * @param attrName
	 * @param attrValue
	 * @param text
	 * @return
	 */
	private Element addSubELment(Element parentElement,String elementName,String attrName,String attrValue,String text) {
		Element element = parentElement.addElement(elementName);//向指定元素节点中增加子元素节
		if (StringUtil.isNotBlank(attrName)) element.addAttribute(attrName, attrValue);//
		if (StringUtil.isNotBlank(text))element.addText(text);
		return element;
	}

	/**
	 * 操作文档对象：使用XPath表达式解析
	 * @param document
	 */
	private void operate_iterate_print_withXPth(Document document) {
		List<Node> nodes = document.selectNodes("//作者");
		for (int i = 0; i < nodes.size(); i++) {
			Element element = (Element) nodes.get(i);
			System.out.println(element.getText());
		}
	}


	/**
	 * 操作文档对象:遍历打印节点内容
	 * @param document
	 */
	private void operate_iterate_print(Element node) {
		// 当前节点的名称、文本内容和属性
		System.out.println("----------"+node.getName()+"----------");
		System.out.println("文本内容：" + node.getText());

		List<Attribute> listAttr = node.attributes();// 当前节点的所有属性的list
		for (Attribute attr : listAttr) {// 遍历当前节点的所有属性
			System.out.println("属性：" + attr.getName() + "=" + attr.getValue());
		}
		
		// 递归遍历当前节点所有的子节点
		List<Element> listElement = node.elements();// 所有一级子节点的list
		for (Element e : listElement) {// 遍历所有一级子节点
			this.operate_iterate_print(e);// 递归
		}
	}

	/**
	 * 获取文档对象
	 * @param filepath
	 * @return
	 */
	private Document getDocument(String filepath) {
		// 创建解析器
		SAXReader reader = new SAXReader();
		try {
			// 解析文档（获取文档对象）
			Document document = reader.read(Dom4j1.class.getClassLoader().getResourceAsStream(filepath));
			return document;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
