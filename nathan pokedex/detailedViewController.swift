import Foundation
import UIKit

class detailedViewController:UIViewController{
    @IBOutlet var pokemonLabel:UILabel!
    @IBOutlet var pokemonImage:UIImageView!
    
    @IBOutlet var healthStat:UILabel!
    @IBOutlet var attackStat:UILabel!
    @IBOutlet var defenseStat:UILabel!
    @IBOutlet var specialAttackStat:UILabel!
    @IBOutlet var specialDefenseStat:UILabel!
    @IBOutlet var speedStat:UILabel!
    
    
    var data: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = data as? [String:Any] {
            if let sprites = data["sprites"] as? [String:Any]{
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
            if let species = data["species"] as? [String:Any]{
                self.pokemonLabel.text = species["name"] as Any as? String
            }
            if let stats = data["stats"] as? [Int:Any]{
                self.healthStat.text = stats[6] as? String
            }
            if let stats = data["stats"] as? [Int:Any]{
                self.attackStat.text = stats[5] as? String
            }
            if let stats = data["stats"] as? [Int:Any]{
                self.defenseStat.text = stats[4] as? String
            }
            if let stats = data["stats"] as? [Int:Any]{
                self.specialAttackStat.text = stats[3] as? String
            }
            if let stats = data["stats"] as? [Int:Any]{
                self.specialDefenseStat.text = stats[2] as? String
            }
            if let stats = data["stats"] as? [Int:Any]{
                self.speedStat.text = stats[1] as? String
            }
            
                
//                self.healthStat.text = stats["stat"["name"["hp"["base_stat"]]]]
//                self.attackStat.text = stats[]
//                self.defenseStat.text = stats[]
//                self.specialAttackStat.text = stats[]
//                self.specialDefenseStat.text = stats[]
//                self.speedStat.text = stats[]
            
        }
        // Do any additional setup after loading the view, typically from a nib.

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(detailedViewController.buttonTapped(gesture:)))
            pokemonImage.addGestureRecognizer(tapGesture)
            pokemonImage.isUserInteractionEnabled = true
        }
    
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if let vc = segue.destination as? moreDetailedViewController{
           // vc.moreData = data
        //}
   // }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func buttonTapped(gesture: UIGestureRecognizer){
        performSegue(withIdentifier: "detailedSegue", sender: nil)
    }
    }




