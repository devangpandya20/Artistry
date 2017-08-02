/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class ArtistDetailViewController: UIViewController {
  
  var selectedArtist: Artist!
  
  let moreInfoText = "Select For More Info >"
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = selectedArtist.name
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 150
  }
}

extension ArtistDetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return selectedArtist.works.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WorkTableViewCell
    
    let work = selectedArtist.works[indexPath.row]
    
    cell.lblWorkTitle.text = work.title
    cell.imgWorkImage.image = work.image
    
    cell.lblWorkTitle.backgroundColor = UIColor(white: 204/255, alpha: 1)
    cell.lblWorkTitle.textAlignment = .center
    cell.lblWorkInfo.textColor = UIColor(white: 114 / 255, alpha: 1)
    cell.selectionStyle = .none
    
    cell.lblWorkInfo.text = work.isExpanded ? work.info : moreInfoText
    cell.lblWorkInfo.textAlignment = work.isExpanded ? .left : .center
    
    cell.lblWorkTitle.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
    cell.lblWorkInfo.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote)
    return cell
  }
}
extension ArtistDetailViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      guard let cell = tableView.cellForRow(at: indexPath) as? WorkTableViewCell else { return }
      
      var work = selectedArtist.works[indexPath.row];
      work.isExpanded = !work.isExpanded
      selectedArtist.works[indexPath.row] = work //since struct is passed by copy, required to be updat
      
      cell.lblWorkInfo.text = work.isExpanded ? work.info : moreInfoText
      cell.lblWorkInfo.textAlignment = work.isExpanded ? .left : .center

      tableView.beginUpdates()
      tableView.endUpdates()
      tableView.scrollToRow(at: indexPath, at: .top, animated: true)
      
  }
}

