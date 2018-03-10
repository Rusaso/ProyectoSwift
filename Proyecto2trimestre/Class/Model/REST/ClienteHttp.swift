//
//  ClienteHttp.swift
//  Proyecto2trimestre
//
//  Created by juandaniel on 01/03/2018.
//  Copyright © 2018 juandi. All rights reserved.
//

import Foundation
class ClienteHttp{
    let urlApi: String = "https://proyecto2-yusaso.c9users.io/IosPanaderia/"
    let respuesta: OnHttpResponse
    var urlPeticion: URLRequest
    var auth: String
    
    /*
     target - acción a ejecutar urlApi + target
     responseObject - objeto a través del cual se pasa el resultado que se obtiene
     method - get, post, put, delete
     data - diccionario con los datos que se quieren pasar en el body de la petición (se convierte a objeto json)
     */
    init?(target: String, responseObject: OnHttpResponse, _ method: String = "GET", _ data:[String:Any] = [:], auth:String) {
        guard let url = URL(string: self.urlApi + target) else { return nil
        }
        self.respuesta = responseObject
        self.urlPeticion = URLRequest(url: url)
        self.urlPeticion.httpMethod = method
        self.auth = auth
        self.urlPeticion.addValue(auth, forHTTPHeaderField: "authorization")
        self.urlPeticion.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if method != "GET" && data.count > 0 {
            guard let json = RestJsonUtil.dictToJson(dic: data) else {
                return nil
            }
            
            self.urlPeticion.httpBody = json
        }
    }
    
    //doInBackground
    func request() {
        //iniciar el símbolo de red
        let sesion = URLSession(configuration: URLSessionConfiguration.default)
        let task = sesion.dataTask(with: self.urlPeticion, completionHandler: self.callBack)
        task.resume()
    }
    
    //onPostExecute
    private func callBack(_ data: Data?, _ respuesta: URLResponse?, _ error: Error?) {
        DispatchQueue.main.async {
            //finalizar el símbolo de red
            guard error == nil else { //si error no es nil, muestra el mensaje
                self.respuesta.onErrorReceivingData(message: "error")
                return
            }
            guard let datos = data else { //si datos no es igual a data, muestra el error
                self.respuesta.onErrorReceivingData(message: "error datos")
                return
            }
            self.respuesta.onDataReceived(data: datos)
        }
    }
    
}
