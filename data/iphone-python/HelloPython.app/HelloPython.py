import objc
import _uicaboodle
from objc import YES, NO
objc.loadBundle('UIKit', globals(), '/System/Library/Frameworks/UIKit.framework')
UIApplication = objc.lookUpClass('UIApplication')
UITable = objc.lookUpClass('UITable')
UIWindow = objc.lookUpClass('UIWindow')
UIHardware = objc.lookUpClass('UIHardware')

class PYApplication(UIApplication):
    def applicationDidFinishLaunching_(self, unused):
        frame = UIHardware.fullScreenApplicationContentRect()
        self.window = UIWindow.alloc().initWithFrame_(frame)

        self.view = UIView.alloc().initWithFrame_(self.window.bounds())
        self.window.setContentView_(self.view)

        self.window.orderFront_(self)
        self.window.makeKey_(self)
        self.window._setHidden_(NO)

        navsize = UINavigationBar.defaultSize()
        navrect = ((0, 0), navsize)

        self.navbar = UINavigationBar.alloc().initWithFrame_(navrect);
        self.view.addSubview_(self.navbar)

        self.navbar.setBarStyle_(1)
        self.navbar.setDelegate_(self)

        navitem = UINavigationItem.alloc().initWithTitle_('Contacts')
        self.navbar.pushNavigationItem_(navitem)

        bounds = self.view.bounds()
        tblrect = ((0, navsize[0]), (bounds[1][0] - navsize[0], bounds[1][1]))

        self.table = UITable.alloc().initWithFrame_(tblrect)
        self.view.addSubview_(self.table)

        self.table.reloadData()

_uicaboodle.UIApplicationMain(['HelloPython'], PYApplication)
