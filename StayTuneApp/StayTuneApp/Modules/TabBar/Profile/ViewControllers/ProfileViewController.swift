//
//  ProfileViewController.swift
//  StayTuneApp
//
//  Created by Rishat on 24.03.2021.
//

import UIKit
import KeychainAccess

class ProfileViewController: UIViewController, CAPSPageMenuDelegate {

    @IBOutlet weak var avatarImgV: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var city: UILabel!

    @IBOutlet weak var placesBtn: UIButton!
    @IBOutlet weak var friendsBtn: UIButton!
    @IBOutlet weak var favoritesBtn: UIButton!
    @IBOutlet weak var changePhotoBtn: UIButton!
    @IBOutlet weak var telegram: UITabBarItem!

    @IBOutlet weak var placesDotView: UIView!
    @IBOutlet weak var favoritesDotView: UIView!
    @IBOutlet weak var friendsDotView: UIView!

    var pageMenu: CAPSPageMenu?
    var coordinator: ProfileCoordinator?
    var controllerArray: [UIViewController] = []
    let presenter = ProfilePresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        presenter.view = self
        presenter.viewDidLoad()

        // initialize
        setUpTelegram()
        configurePageMenu()
    }

    override func viewDidAppear(_ animated: Bool) {
    }

    // MARK: - Initialize
    func setUpTelegram() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Telegram", style: .plain, target: self, action: #selector(telegramTapped))
    }

    func setUpYourEvents() {
        let yourEventsViewController = YourEventsViewController()
        let yourEventsPresenter = YourEventsListPresenterImplementation(service: RestYourEventsService())
        yourEventsPresenter.onConcertSelected = { [weak coordinator] concert in
            coordinator?.openConcertDetails(concert: concert)
        }
        yourEventsPresenter.view = yourEventsViewController
        yourEventsViewController.presenter = yourEventsPresenter
        controllerArray.append(yourEventsViewController)
    }

    func setUpFavorites() {
        let favoritesViewController = FavoritesViewController()
        let favoritesPresenter = FavoritesListPresenterImplementation(service: RestFavoritesService())
        favoritesPresenter.onConcertSelected = { [weak coordinator] concert in
            coordinator?.openConcertDetails(concert: concert)
        }
        favoritesPresenter.view = favoritesViewController
        favoritesViewController.presenter = favoritesPresenter
        controllerArray.append(favoritesViewController)
    }

    func setUpFriends() {
        let friendsController = FriendsViewController()
        let friendsPresenter = FriendsListPresenterImplementation(service: RestFriendsService())
        friendsPresenter.view = friendsController
        friendsController.presenter = friendsPresenter
        controllerArray.append(friendsController)
    }

    func configurePageMenu() {
        setUpYourEvents()
        setUpFriends()
        setUpFavorites()

        let param: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .menuHeight(0),
            .useMenuLikeSegmentedControl(false),
            .menuItemSeparatorPercentageHeight(0.1)
        ]
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: .zero, pageMenuOptions: param)
        pageMenu?.delegate = self
        pageMenu!.view.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(pageMenu!.view)

        pageMenu?.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12).isActive = true
        pageMenu?.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12).isActive = true
        pageMenu?.view.topAnchor.constraint(equalTo: self.placesDotView.bottomAnchor, constant: 12).isActive = true
        pageMenu?.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -12).isActive = true
    }

    @IBAction func clickedPlaces(_ sender: Any) {
        pageMenu?.moveToPage(0)
        updateMenuState(index: 0)
    }

    @IBAction func clickedFavorites(_ sender: Any) {
        pageMenu?.moveToPage(1)
        updateMenuState(index: 1)
    }

    @IBAction func clickedFriends(_ sender: Any) {
        pageMenu?.moveToPage(2)
        updateMenuState(index: 2)
    }

    @IBAction func clickedChangePhoto(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Take photo", style: .default, handler: {_ in
            self.chooseImage(choose: .takePhoto)
        }))
        alert.addAction(UIAlertAction(title: "Select photo", style: .default, handler: {_ in
            self.chooseImage(choose: .library)
        }))

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }

    private func chooseImage(choose: PhotoChoose) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        switch choose {
        case .library:
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                picker.delegate = self
                picker.sourceType = .photoLibrary
            }

        case .takePhoto:
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.delegate = self
                picker.sourceType = .camera
            }
        }
        self.present(picker, animated: true, completion: nil)
    }

    func didMoveToPage(_ controller: UIViewController, index: Int) {

        updateMenuState(index: index)
    }

    func updateMenuState(index: Int) {
        if index == 0 {
            placesBtn.update_ProfileMenuStateFor(isSelected: true)
            favoritesBtn.update_ProfileMenuStateFor(isSelected: false)
            friendsBtn.update_ProfileMenuStateFor(isSelected: false)

            placesDotView.update_DotStateFor(isSelected: true)
            favoritesDotView.update_DotStateFor(isSelected: false)
            friendsDotView.update_DotStateFor(isSelected: false)
        } else if index == 1 {
            placesBtn.update_ProfileMenuStateFor(isSelected: false)
            favoritesBtn.update_ProfileMenuStateFor(isSelected: true)
            friendsBtn.update_ProfileMenuStateFor(isSelected: false)

            placesDotView.update_DotStateFor(isSelected: false)
            favoritesDotView.update_DotStateFor(isSelected: true)
            friendsDotView.update_DotStateFor(isSelected: false)
        } else if index == 2 {
            placesBtn.update_ProfileMenuStateFor(isSelected: false)
            favoritesBtn.update_ProfileMenuStateFor(isSelected: false)
            friendsBtn.update_ProfileMenuStateFor(isSelected: true)

            placesDotView.update_DotStateFor(isSelected: false)
            favoritesDotView.update_DotStateFor(isSelected: false)
            friendsDotView.update_DotStateFor(isSelected: true)
        }
    }

    func updatePhoto(url: URL) {
        avatarImgV.kf.setImage(with: url, placeholder: UIImage(named: "No-Image-Placeholder"))
    }

    @objc func telegramTapped() {
        guard let telegram = presenter.viewTelegram() else { return alert(message: "Error get telegram") }
        telegramAlert(message: telegram)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)

        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            presenter.changePhoto(image: image)
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            presenter.changePhoto(image: image)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

enum PhotoChoose {
    case takePhoto
    case library
}
