package com.lsy.code.xml;

import com.lsy.code.utils.StringUtil;
import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import java.util.List;

public class Dom4jUtil {

    /**
     * 获取文档节点对象
     * @param filepath
     * @return
     */
    public static Document getDocument(String filepath) {
        // 创建解析器
        SAXReader reader = new SAXReader();
        try {
            // 解析文档节点（获取文档节点对象）
            Document document = reader.read(Dom4j1.class.getClassLoader().getResourceAsStream(filepath));
            return document;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 向指定元素节点添加子元素节点
     * @param parentElement
     * @param elementName
     * @param attrName
     * @param attrValue
     * @param text
     * @return
     */
    public static Element addSubELment(Element parentElement,String elementName,String attrName,String attrValue,String text) {
        Element element = parentElement.addElement(elementName);//向指定元素节点中增加子元素节点
        if (StringUtil.isNotBlank(attrName)) element.addAttribute(attrName, attrValue);//向元素节点添加属性节点
        if (StringUtil.isNotBlank(text))element.addText(text);//向元素节点添加文本节点
        return element;
    }

    /**
     * 操作文档节点对象:遍历打印节点内容
     * @param node
     */
    public static void operate_iterate_print(Element node) {
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
            operate_iterate_print(e);// 递归
        }
    }
}
