//
//  PageDataManager.swift
//  AmericanChronicle
//
//  Created by Ryan Peterson on 10/17/15.
//  Copyright © 2015 ryanipete. All rights reserved.
//

/// Conforming types can be used as the Page module's data manager.
public protocol PageDataManagerInterface {
    func downloadPage(remoteURL: NSURL, completionHandler: (NSURL, NSURL?, NSError?) -> Void)
    func cancelDownload(remoteURL: NSURL)
    func isDownloadInProgress(remoteURL: NSURL) -> Bool
}

/// Responsibilities:
/// * Knows which service to use.
public class PageDataManager: NSObject, PageDataManagerInterface {

    private let pageService: PageServiceInterface
    private let cachedPageService: CachedPageServiceInterface
    private let coordinatesService: OCRCoordinatesServiceInterface
    private var contextID: String { return "\(unsafeAddressOf(self))" }

    /// * parameters:
    ///     * pageService: The service to use for API requests.
    ///     * cachedPageService: The service to check before making API requests.
    public required init(
        pageService: PageServiceInterface = PageService(),
        cachedPageService: CachedPageServiceInterface = CachedPageService(),
        coordinatesService: OCRCoordinatesServiceInterface = OCRCoordinatesService())
    {
        self.pageService = pageService
        self.cachedPageService = cachedPageService
        self.coordinatesService = coordinatesService
        super.init()
    }

    public func downloadPage(remoteURL: NSURL, completionHandler: (NSURL, NSURL?, NSError?) -> Void) {
        if let fileURL = cachedPageService.fileURLForRemoteURL(remoteURL) {
            completionHandler(remoteURL, fileURL, nil)
            return
        }

        pageService.downloadPage(remoteURL, contextID: contextID) { fileURL, error in
            if let fileURL = fileURL where error == nil {
                self.cachedPageService.cacheFileURL(fileURL, forRemoteURL: remoteURL)
            }
            completionHandler(remoteURL, fileURL, error as? NSError)
        }
    }

    public func cancelDownload(remoteURL: NSURL) {
        pageService.cancelDownload(remoteURL, contextID: contextID)
    }

    public func isDownloadInProgress(remoteURL: NSURL) -> Bool {
        return pageService.isDownloadInProgress(remoteURL)
    }

    public func startOCRCoordinatesRequest(
        lccn: String,
        date: NSDate,
        edition: String,
        sequence: String,
        completionHandler: (OCRCoordinates?, NSError?) -> Void)
    {
        coordinatesService.startRequest(lccn, date: date, edition: edition, sequence: sequence, contextID: contextID, completionHandler: { coordinates, err in
            completionHandler(coordinates, err as? NSError)
        })
    }

    public func cancelOCRCoordinatesRequest(
        lccn: String,
        date: NSDate,
        edition: String,
        sequence: String)
    {
        coordinatesService.cancelRequest(lccn, date: date, edition: edition, sequence: sequence, contextID: contextID)
    }

    public func isOCRCoordinatesRequestInProgress(
        lccn: String,
        date: NSDate,
        edition: String,
        sequence: String) -> Bool
    {
        return coordinatesService.isRequestInProgress(lccn, date: date, edition: edition, sequence: sequence, contextID: contextID)
    }
}
