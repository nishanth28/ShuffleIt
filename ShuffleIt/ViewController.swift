//
//  ViewController.swift
//  ShuffleIt
//
//  Created by Nishanth P on 11/27/16.
//  Copyright © 2016 Nishapp. All rights reserved.
//

import UIKit
import LocalAuthentication
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    @IBOutlet weak var facebookLogin: UIButton!
    
    
    var display_Name = ""
    var email = ""
    var displaypic_url : URL?
    var display_pic : UIImage?
   
    
    @IBAction func facebookLogin(_ sender: Any) {
    
        let FbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        
        FbLoginManager.logIn(withReadPermissions: ["email"], from: self) {(result, error) in
            if error == nil{
        let credential = FIRFacebookAuthProvider.credential(withAccessToken:FBSDKAccessToken.current().tokenString)
                print("Logged in Through Facebook")
                self.fireBaseAuth(credential)
                
                }
            else{
                print("FBLoginError")
            }
            
        }
       
        }
    
    func fireBaseAuth(_ credential : FIRAuthCredential ){
        
        FIRAuth.auth()?.signIn(with:credential,completion : { (user, error) in
            
            if error != nil{
                print("Unable to login with Firebase -\(error)")
                
            }else
            {
                  self.display_Name = (user?.displayName)!
                  self.email = (user?.email)!
                  let displaypic_url = (user?.photoURL)!
                print(displaypic_url)
                  
                
                let data = try? Data(contentsOf: displaypic_url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                self.display_pic = UIImage(data: data!)
                
               /* DispatchQueue.global().async {
                    let data = try? Data(contentsOf: displaypic_url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    DispatchQueue.main.async {
                        self.display_pic = UIImage(data: data!)!
                    }
                }
                */
                
                print("Succesfull login with \n Display_Name:\(self.display_Name) \n Email_id:\(self.email)")
                
                
                    self.performSegue(withIdentifier: "LoginSegue", sender: self)
                
            }
        
        
        
        
        })
        
        
    }
    
    /*func getFBUserData() {
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"name"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //self.FBinfo = result as AnyObject
                    print(result!)
                }
            })
        }
    }
*/
    var Auth : Bool = false

    
    @IBAction func Login(_ sender: Any) {
        
        if let email = userName.text, let pwd = password.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: {
                (user,error) in
                if error == nil{
                    self.performSegue(withIdentifier: "LoginSegue", sender: self)
                    print("Signed in using firebase")
                }
                else{
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user,error) in
                        if error != nil{
                            print("Unable to sign in")
                        }else{
                            self.performSegue(withIdentifier: "LoginSegue", sender: self)
                            print("Successfully authenticated with FireBase")
                        }
                    })
                print(error)
                }
            })
        }
            self.performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  fingerPrint()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func fingerPrint() {
        
        let context : LAContext = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "TouchID to Sign In", reply: { (Success, error) in
                if Success{
                    print("Auth-Success")
                    DispatchQueue.main.async(){
                    self.performSegue(withIdentifier: "LoginSegue", sender: self)
                        self.Auth = true}
                }
                else{
                    print("Auth-failure")
                    self.Auth = false
            
                }
            })
        }

    
    }
    
    
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "LoginSegue" {
        let tabBar : UITabBarController = segue.destination as! UITabBarController
        let pv : ProfileViewController = tabBar.viewControllers?.first as! ProfileViewController
         pv.display_Name = self.display_Name
         pv.display_Pic = self.display_pic
         
        }
        else{
            print("problem")
        }
    }


}

