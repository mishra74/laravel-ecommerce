@extends('front.layouts.app')

@section('content')
<style>
    .about__thumb--img {
        width: 100%;
    }

    .about__thumb--play {
        top: 40%;
        padding: 0;
        border: 0;
        right: 42%;
        position: absolute;
    }

    @media only screen and (max-width: 991px) {
        .about__thumb--play {
            top: 50%;
            -webkit-transform: translatey(-50%);
            transform: translatey(-50%);
            margin-top: 0;
        }
    }

    @media only screen and (max-width: 575px) {
        .about__content {
            text-align: center;
        }
    }

    .about__content--subtitle {
        font-size: 2rem;
        font-weight: 600;
        line-height: 2.2rem;
    }

    @media only screen and (max-width: 575px) {
        .about__content--subtitle {
            font-size: 1.8rem;
            margin-bottom: 1.2rem;
        }
    }

    .about__content--maintitle {
        font-weight: 700;
    }

    @media only screen and (min-width: 992px) {
        .about__content--maintitle {
            font-size: 3rem;
            line-height: 3.7rem;
        }
    }

    @media only screen and (max-width: 575px) {
        .about__content--maintitle {
            line-height: 2.8rem;
            margin-bottom: 1.5rem;
        }
    }

    .about__content--desc {
        font-size: 1rem;
        line-height: 1.8rem;
        color: #606060;
    }

    @media only screen and (max-width: 575px) {
        .about__content--desc {
            font-size: 1.5rem;
            line-height: 2.5rem;
        }
    }

    @media only screen and (max-width: 575px) {
        .about__author {
            -webkit-box-pack: center;
            -ms-flex-pack: center;
            justify-content: center;
        }
    }

    .about__author--name {
        font-weight: 600;
        line-height: 2.6rem;
    }

    .about__author--signature {
        margin-left: 1.5rem;
    }

    .counterup__banner__bg2 {
        background: url(/front-assets/images/banner-bg4.png);
        background-repeat: no-repeat;
        background-attachment: scroll;
        background-position: center center;
        background-size: cover;
        position: relative;
    }

    /* Dark overlay */
    .counterup__banner__bg2::before {
        position: absolute;
        content: "";
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.7);
        /* Black with transparency */
        left: 0;
        top: 0;
    }

    /* Ensure text remains white */
    .counterup__banner--items__text,
    .counterup__banner--items__number {
        color: #ffffff !important;
        /* Force white text */
        position: relative;
        /* Ensure text stays above the overlay */
        z-index: 2;
    }

    .counterup__banner--inner {
        padding: 60px 0;
    }

    @media only screen and (max-width: 575px) {
        .counterup__banner--inner {
            -ms-flex-wrap: wrap;
            flex-wrap: wrap;
            padding: 60px 0 38px;
        }
    }

    @media only screen and (min-width: 768px) {
        .counterup__banner--inner {
            padding: 70px 0;
        }
    }

    @media only screen and (min-width: 992px) {
        .counterup__banner--inner {
            padding: 80px 0;
        }
    }

    @media only screen and (min-width: 1200px) {
        .counterup__banner--inner {
            padding: 100px 0;
        }
    }

    @media only screen and (min-width: 1600px) {
        .counterup__banner--inner {
            padding: 150px 0;
        }
    }

    @media only screen and (max-width: 575px) {
        .counterup__banner--items {
            width: 50%;
            margin-bottom: 22px;
        }
    }

    .counterup__banner--items__text {
        font-size: 1.4rem;
        line-height: 2.3rem;
        margin-bottom: 10px;
        font-weight: 400;
    }

    @media only screen and (min-width: 768px) {
        .counterup__banner--items__text {
            font-size: 1.6rem;
            line-height: 2.4rem;
            margin-bottom: 11px;
        }
    }

    @media only screen and (min-width: 992px) {
        .counterup__banner--items__text {
            font-size: 1.7rem;
            line-height: 2.7rem;
        }
    }

    @media only screen and (min-width: 1200px) {
        .counterup__banner--items__text {
            font-size: 2rem;
            line-height: 3.2rem;
        }
    }

    .counterup__banner--items__number {
            {
                {
                -- font-family: var(--font-lora);
                --
            }
        }

        font-weight: 400;
        font-size: 2rem;
        line-height: 2rem;
    }

    @media only screen and (min-width: 768px) {
        .counterup__banner--items__number {
            font-size: 3.3rem;
        }
    }

    @media only screen and (min-width: 992px) {
        .counterup__banner--items__number {
            font-size: 3.5rem;
            line-height: 3.5rem;
        }
    }

    @media only screen and (min-width: 1200px) {
        .counterup__banner--items__number {
            font-size: 4rem;
            line-height: 4.5rem;
        }
    }


    .counterup__banner--items__text,
    .counterup__banner--items__number {
        color: rgb(249, 254, 254) !important;
        /* Change this to your desired color */
    }

</style>
<section class="breadcrumb__section breadcrumb__bg mb-3 mt-2">
    <div class="container">
        <div class="row row-cols-1">
            <div class="col">
                <div class="breadcrumb__content text-center">
                    <h1 class="breadcrumb__content--title text-black mb-25">About Us</h1>
                    <ul class="breadcrumb__content--menu d-flex justify-content-center">
                    <br>
                        {{-- <li class="breadcrumb__content--menu__items"><a class="text-black" href="index.php">Home</a></li>
                        <li class="breadcrumb__content--menu__items"><span class="text-black">About Us</span></li> --}}
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="about__section section--padding mb-95">
    <div class="container">
        <div class="row">
            <!-- About Section Left Image -->
            <div class="col-lg-6">
                <div class="about__thumb d-flex">
                    <div class="about__thumb--items">
                        <img class="about__thumb--img border-radius-5 display-block" 
                             src="/front-assets/images/about-thumb-list2.png" 
                             alt="about-thumb">
                    </div>
                    <div class="about__thumb--items position__relative">
                        <img class="about__thumb--img border-radius-5 display-block" 
                             src="/front-assets/images/about-thumb-list1.png" 
                             alt="about-thumb">
                        <div class="banner__bideo--play about__thumb--play">
                            {{-- Video Play Button (Commented Out)
                            <a class="banner__bideo--play__icon about__thumb--play__icon glightbox" 
                               href="https://vimeo.com/115041822" data-gallery="video">
                                <svg id="play" xmlns="http://www.w3.org/2000/svg" width="40.302" 
                                     height="40.302" viewBox="0 0 46.302 46.302">
                                    <g id="Group_193" data-name="Group 193">
                                        <path id="Path_116" data-name="Path 116" 
                                              d="M39.521,6.781a23.151,23.151,0,0,0-32.74,32.74,23.151,23.151,0,0,0,32.74-32.74ZM23.151,44.457A21.306,21.306,0,1,1,44.457,23.151,21.33,21.33,0,0,1,23.151,44.457Z" 
                                              fill="currentColor"/>
                                        <g id="Group_188" transform="translate(15.588 11.19)">
                                            <path id="Path_117" data-name="Path 117" 
                                                  d="M190.3,133.213l-13.256-8.964a3,3,0,0,0-4.674,2.482v17.929a2.994,2.994,0,0,0,4.674,2.481l13.256-8.964a3,3,0,0,0,0-4.963Z" 
                                                  transform="translate(-172.366 -123.734)" 
                                                  fill="currentColor"/>
                                        </g>
                                    </g>
                                </svg>
                                <span class="visually-hidden">Video Play</span>
                            </a>
                            --}}
                        </div>
                    </div>
                </div>
            </div>

            <!-- About Section Right Content -->
            <div class="col-lg-6">
                <div class="about__content">
                    <h2 class="about__content--maintitle mb-25">
                        We do not buy from the open market & traders.
                    </h2>
                    <p class="about__content--desc mb-20">
                        Euor Fashion is a leading clothing brand that specializes in 
                        producing high-quality women's clothing. With years of experience 
                        in the fashion industry, we are committed to providing our customers 
                        with the latest and most fashionable designs.
                    </p>
                    <p class="about__content--desc mb-20">
                        We have a team of skilled and experienced designers who are passionate 
                        about creating unique and stylish pieces that are loved by women all 
                        around the world. At Euor Fashion, we understand that every customer 
                        has unique requirements, and we strive to fulfill them to the best 
                        of our ability.
                    </p>
                    <p class="about__content--desc mb-20">
                        We primarily cater to bulk orders from retailers, but we also welcome 
                        individual customers who wish to order a single catalog of products. 
                        Our product line includes everything from traditional ethnic wear to 
                        modern western outfits, ensuring a diverse range of options for 
                        different tastes and preferences.
                    </p>
                    <p class="about__content--desc mb-25">
                        At Euor Fashion, quality is of utmost importance. We use only the 
                        finest materials and fabrics, and our garments undergo rigorous 
                        quality checks at every stage of production.
                    </p>
                    <p class="about__content--desc mb-25">
                        In addition to our commitment to quality, we place great emphasis 
                        on customer satisfaction. We believe that a satisfied customer is 
                        the key to our success, and we strive to exceed their expectations 
                        at every step of the way.
                    </p>
                    <p class="about__content--desc mb-25">
                        Whether it's providing customer support or delivering orders on time, 
                        we go above and beyond to ensure a seamless shopping experience. Our 
                        website is easy to navigate, offering detailed product descriptions, 
                        images, secure payment options, and a hassle-free returns policy.
                    </p>
                    <p class="about__content--desc mb-25">
                        Euor Fashion is dedicated to providing high-quality clothing to customers 
                        worldwide. Whether you're a retailer or an individual customer, we welcome 
                        you to browse our collection and place an order today. 
                    </p>
                    <p class="about__content--desc mb-25">
                        Stay updated with the latest events, sales, and offers!
                    </p>

                    {{-- About Author Section (Commented Out) --}}
                    {{-- 
                    <div class="about__author position__relative d-flex align-items-center">
                        <div class="about__author--left">
                            <h4 class="about__author--name">Bruce Sutton</h4>
                            <span class="about__author--rank">Spa Manager</span>
                        </div>
                        <img class="about__author--signature display-block" 
                             src="assets/img/icon/signature.png" 
                             alt="signature">
                    </div>
                    --}}
                </div>
            </div>
        </div>
    </div>
</section>

<div class="counterup__banner--section counterup__banner__bg2" id="funfactId">
    <div class="container">
        <div class="row row-cols-1 align-items-center">
            <div class="col">
                <div class="counterup__banner--inner position__relative d-flex align-items-center justify-content-between">
                    <div class="counterup__banner--items text-center">
                        <h2 class="counterup__banner--items__text text-white">YEARS OF <br>
                            FOUNDATION</h2>
                        <span class="counterup__banner--items__number js-counter text-white" data-count="50">10</span>
                    </div>
                    <div class="counterup__banner--items text-center">
                        <h2 class="counterup__banner--items__text text-white">SKILLED TEAM <br>
                            MEMBERS </h2>
                        <span class="counterup__banner--items__number js-counter text-white" data-count="100">20</span>
                    </div>
                    <div class="counterup__banner--items text-center">
                        <h2 class="counterup__banner--items__text text-white">HAPPY <br>
                            CUSTOMERS</h2>
                        <span class="counterup__banner--items__number js-counter text-white" data-count="80">1000</span>
                    </div>
                    <div class="counterup__banner--items text-center">
                        <h2 class="counterup__banner--items__text text-white">MONTHLY <br>
                            ORDERS</h2>
                        <span class="counterup__banner--items__number js-counter text-white" data-count="70">500</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


@endsection
