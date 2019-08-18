final class NRNovelChapter: FTServiceModel {

    // Request Model
    var identifier: String?
    var shortTitle: String?
    var title: String?
    var content: String?
    var releaseDate: String?

    // Response Model
    var response: NRNovelChapter?

    /* Coding Keys */
    enum CodingKeys: String, CodingKey {
        case identifier
        case shortTitle
        case title = "name"
        case content
        case releaseDate
        case response
    }
}
