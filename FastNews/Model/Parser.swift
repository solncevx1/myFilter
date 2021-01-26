//
//  Parser.swift
//  FastNews
//
//  Created by Максим Солнцев on 1/23/21.
//

import Foundation


class Parser: NSObject, XMLParserDelegate {
    private var items: [RSSItem] = []
    private var currentElement = ""
    private var currentTitle = ""
    private var currentDescription = ""
    private var currentDate = "" {
        didSet {
            currentDate = currentDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentImage = "" {
        didSet {
            currentImage = currentImage.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
      
    
    private var complitionHandelr: (([RSSItem]) -> Void)?
    
    // MARK: - Methods
    
    func parse(url: String, complition: (([RSSItem]) -> Void)? ) {

        self.complitionHandelr = complition
        
        let urlString = url
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {(data, response, error ) in
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                return
            }
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        .resume()
    }
    
    // MARK: - Delegate methods
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        switch currentElement {
        case "item" :
            currentTitle = ""
            currentDescription = ""
            currentDate = ""
            currentImage = ""
        case "enclosure":
            guard let urlToString = attributeDict["url"] else { return }
            currentImage += urlToString
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch currentElement {
        case "title": currentTitle += string
        case "description": currentDescription += string
        case "pubDate": currentDate += string
        case "enclosure": currentImage += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            let rssItem = RSSItem(name: currentTitle, description: currentDescription, publishDate: currentDate, image: currentImage)
            self.items.append(rssItem)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        complitionHandelr?(items)
    }
}
