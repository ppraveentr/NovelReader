final class NRNovelChapter: FTServiceModel {

    // Request Model
    var identifier: String? = nil
    var shortTitle: String? = nil
    var title: String? = nil
    var content: String? = nil
    var releaseDate: String? = nil

    // Response Model
    var response: NRNovelChapter? = nil

    /* Coding Keys */
    enum CodingKeys: String, CodingKey  {
        case identifier
        case shortTitle
        case title = "name"
        case content
        case releaseDate
        case response
    }
    
}

