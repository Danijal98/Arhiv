//
//  SettingsView.swift
//  MyDocKeeper
//
//  Created by Danijal Azerovic on 4/29/24.
//

import SwiftUI

struct SettingsView: View {    
    @AppStorage("LOCALE_IDENTIFIER") private var currentLocale: String = "en"
    private let availableLocales = [Locale(identifier: "en"), Locale(identifier: "hr")]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(availableLocales, id: \.identifier) { locale in
                    Button(action: {
                        setLocale(locale)
                    }) {
                        HStack {
                            Text(Locale.current.localizedString(forIdentifier: locale.identifier) ?? locale.identifier)
                            if currentLocale == locale.identifier {
                                Spacer()
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
            .navigationTitle("choose-language")
        }
    }
    
    func setLocale(_ newLocale: Locale) {
        self.currentLocale = newLocale.identifier
        UserDefaults.standard.set([newLocale.identifier], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        exit(0)
    }

}

#Preview {
    SettingsView()
}
