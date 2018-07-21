import UIKit

class ViewController: UIViewController {

    @IBOutlet var pokemonImage:UIImageView!
    @IBOutlet var searchBox:UITextField!
    var responseJSON: Any?
    
    @IBAction func searchPokemon(sender:AnyObject){
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/" + searchBox.text!)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            print(JSONSerialization.isValidJSONObject(data))
            self.responseJSON = try? JSONSerialization.jsonObject(with: data)
            if let responseJSON = self.responseJSON as? [String:Any] {
                if let species = responseJSON["species"] as? [String:Any]{
                    print(species["name"] as Any)
                }
                if let sprites = responseJSON["sprites"] as? [String:Any]{
                    do{
                        let imageURL = URL(string: sprites["front_default"] as! String)
                        let imageData = try Data(contentsOf: imageURL!)
                        DispatchQueue.main.async{
                            self.pokemonImage.image = UIImage(data: imageData)
                            print(sprites["front_default"] as Any)
                        }
                    } catch{
                        print(error)
                    }
                }
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.imageTapped(gesture:)))
        pokemonImage.addGestureRecognizer(tapGesture)
        pokemonImage.isUserInteractionEnabled = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? detailedViewController{
            vc.data = responseJSON
        }
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer){
        performSegue(withIdentifier: "detailedSegue", sender: nil)
    }
}




