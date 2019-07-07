/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

private let presentIncomingCallViewControllerSegue = "PresentIncomingCallViewController"
private let presentOutgoingCallViewControllerSegue = "PresentOutgoingCallViewController"
private let callCellIdentifier = "CallCell"

class CallsViewController: UITableViewController {
  var callManager: CallManager!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    callManager = AppDelegate.shared.callManager
    
    callManager.callsChangedHandler = { [weak self] in
      guard let self = self else { return }
      self.tableView.reloadData()
    }
  }
  
  @IBAction private func unwindForNewCall(_ segue: UIStoryboardSegue) {
    // 1.
    guard
      let newCallController = segue.source as? NewCallViewController,
      let handle = newCallController.handle
      else {
        return
    }
    
    let videoEnabled = newCallController.videoEnabled
    
    // 2.
    let backgroundTaskIdentifier =
      UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
      AppDelegate.shared.displayIncomingCall(
        uuid: UUID(),
        handle: handle,
        hasVideo: videoEnabled
      ) { _ in
        UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
      }
    }
  }
}

// MARK: - UITableViewDataSource
extension CallsViewController {
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return callManager.calls.count
  }
  
  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let call = callManager.calls[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: callCellIdentifier) as! CallTableViewCell
    cell.callerHandle = call.handle
    cell.callState = call.state
    cell.incoming = !call.outgoing
    
    return cell
  }
}

// MARK - UITableViewDelegate
extension CallsViewController {
  override func tableView(
    _ tableView: UITableView,
    titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath
  ) -> String? {
    return "End"
  }
}
