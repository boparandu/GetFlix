//
//  MovieViewController.swift
//  GetFlix
//
//  Created by user on 2/14/21.
//

import UIKit
import AlamofireImage

class MovieViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var movies = [[String:Any]]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { [self] (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
              
              movies = dataDictionary["results"] as! [[String:Any]]
            tableView.reloadData()
              print(movies)

              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }

            
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let title = movies[indexPath.row]["title"] as! String
        let overview = movies[indexPath.row]["overview"] as! String
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movies[indexPath.row]["poster_path"] as! String
        let posterURL = URL(string: baseUrl + posterPath)
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        cell.posterImage.af_setImage(withURL: posterURL!)
        
        return cell
    }
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
