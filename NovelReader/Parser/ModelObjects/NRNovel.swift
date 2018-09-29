final class NRNovel: FTServiceModel {

    var identifier: String? = nil
    var lastChapter: String? = nil
    var chapterList: [NRNovelChapter]? = nil
    var searchString: String? = nil
    var rating: String? = nil
    var author: String? = nil
    var lastUpdated: String? = nil
    var imageURL: String? = nil
    var genres: [String]? = nil
    var contentDescription: String? = nil
    var artist: String? = nil
    var status: String? = nil
    var views: String? = nil
    var title: String? = nil
    var novelType: String? = nil

    /* Coding Keys */
    enum CodingKeys: String, CodingKey  {
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

    }
    
}
