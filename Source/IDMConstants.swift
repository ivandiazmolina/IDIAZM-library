//
//  Constants.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 04/09/2020.
//


struct Constants {
    
    struct Patterns {
        
        static let email: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let strongPassword: String = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[~£€¥$&+,:;=?¿@#|¬_`'\"ºª<>.^*\\[\\]{}()%!¡\\-\\\\/])[a-zA-Z\\d~£€¥$&+,:;=?¿@#|¬_`'\"ºª<>.^*\\[\\]{}()%!¡\\-\\\\/]{8,}$"
    }
}
