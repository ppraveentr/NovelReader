import NetworkLayer

final class NovelChapterModel: ServiceModel {

    // Request Model
    var identifier: String?
    var shortTitle: String?
    var title: String?
    var content: String?
    var releaseDate: String?

    // Response Model
    var response: NovelChapterModel?

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
