require('babel-polyfill');

global.Navbar = require('components/products/Navbar').default;
global.Navigator = require('components/products/Navigator').default;

global.ImageSlider = require('components/product/ImageSlider').default;

global.ProductList = require('components/list/ProductList').default;
global.UserList = require('components/list/UserList').default;

global.Search = require('components/search/Search').default;
global.Medias = require('components/medias/Medias').default;
global.Media = require('components/medias/Media').default;

global.ImageUploader = require('components/image_dashboard/ImageUploader').default;
global.InstagramPostUploader = require('components/image_dashboard/InstagramPostUploader').default;
global.ImageDashboardUploader = require('components/image_dashboard/ImageDashboardUploader').default;
global.ImageOfInterestList = require('components/image_of_interest/list').default;
global.RoiSelect = require('components/image_uploader/RoiSelect').default;
