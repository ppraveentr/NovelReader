final class NovelModel: ServiceModel {
    var identifier: String?
    var lastChapter: String?
    var chapterList: [NovelChapterModel]?
    var searchString: String?
    var rating: String?
    var author: String?
    var lastUpdated: String?
    var imageURL: String?
    var genres: [String]?
    var contentDescription: String?
    var artist: String?
    var status: String?
    var views: String?
    var title: String?
    var novelType: String?

    var response: NovelModel?
    
    /* Coding Keys */
    enum CodingKeys: String, CodingKey {
        case identifier
        case lastChapter = "lastchapter"
        case chapterList = "chapters"
        case searchString = "nameunsigned"
        case rating
        case author
        case lastUpdated = "lastUpdate"
        case imageURL = "image"
        case genres
        case contentDescription = "summary"
        case artist
        case status
        case views
        case title = "name"
        case novelType = "type"
        case response
    }
}
