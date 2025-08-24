<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Help & Support | E-commerce</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background:#f8f9fa; }
        .page-section { padding:50px 20px; }
        .card { border:none; box-shadow:0 2px 12px rgba(0,0,0,0.08); }
        .card h5 { font-weight:bold; margin-bottom:15px; }
        .faq-item { margin-bottom:15px; }
        .accordion-button { font-weight: 500; color:#0d6efd; }
        .accordion-button:focus { box-shadow:none; }
        .accordion-body { color:#444; }
        .btn-primary i { margin-right:6px; }
    </style>
</head>
<body>

<!-- Navbar Include -->
<jsp:include page="homenav.jsp"/>

<!-- Help & Support Section -->
<div class="container page-section">
    <div class="row">

        <!-- Left Column: Contact Us only -->
        <div class="col-lg-7 mb-4">

            <!-- Contact Us Card -->
            <div class="card p-4">
                <h5><i class="bi bi-telephone-fill"></i> Contact Us</h5>
                <p><i class="bi bi-geo-alt"></i> Remote Location, India</p>
                <p><i class="bi bi-telephone"></i> +91-XXXXXXXXXX</p>
                <p><i class="bi bi-envelope"></i> support@ecommerce.com</p>
                <p><i class="bi bi-clock"></i> Mon–Sat, 9 AM – 8 PM</p>

                <hr>
                <h6>Send us a Message</h6>
                <form action="contactFormHandler.jsp" method="post">
                    <div class="mb-3">
                        <label class="form-label">Your Name</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Message</label>
                        <textarea name="message" rows="4" class="form-control" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary"><i class="bi bi-send-fill"></i> Contact Us</button>
                </form>
            </div>

        </div>

        <!-- Right Column: Policies + FAQ -->
        <div class="col-lg-5 mb-4">

            <!-- Policies Card -->
            <div class="card p-4 mb-4">
                <h5><i class="bi bi-clipboard-check"></i> Our Policies</h5>
                <div class="accordion" id="policyAccordion">

                    <!-- Terms & Conditions -->
                    <div class="accordion-item mb-2">
                        <h2 class="accordion-header" id="policy1">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#termsPolicy" aria-expanded="false" aria-controls="termsPolicy">
                                <i class="bi bi-file-earmark-text me-2"></i> Terms & Conditions
                            </button>
                        </h2>
                        <div id="termsPolicy" class="accordion-collapse collapse" aria-labelledby="policy1" data-bs-parent="#policyAccordion">
                            <div class="accordion-body">
                                <ul>
                                    <li>All products, digital content, and services are for legitimate customer use only.</li>
                                    <li>Users must register with accurate personal and payment information.</li>
                                    <li>Unauthorized redistribution, resale, or sharing of products is strictly prohibited.</li>
                                    <li>Accounts violating our policies may be suspended or terminated without notice.</li>
                                    <li>By using our platform, you agree to comply with all applicable laws and regulations.</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Refund Policy -->
                    <div class="accordion-item mb-2">
                        <h2 class="accordion-header" id="policy2">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#refundPolicy" aria-expanded="false" aria-controls="refundPolicy">
                                <i class="bi bi-arrow-counterclockwise me-2"></i> Refund Policy
                            </button>
                        </h2>
                        <div id="refundPolicy" class="accordion-collapse collapse" aria-labelledby="policy2" data-bs-parent="#policyAccordion">
                            <div class="accordion-body">
                                <ul>
                                    <li>If payment is deducted but access to digital content or products is not granted, a refund will be provided.</li>
                                    <li>Payment gateway or technical issues are tracked until resolved; refunds may take 5-7 business days.</li>
                                    <li>Once access is granted or physical product shipped, purchases are non-refundable.</li>
                                    <li>Refunds are not provided for personal selection errors or accidental purchases.</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Privacy Policy -->
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="policy3">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#privacyPolicy" aria-expanded="false" aria-controls="privacyPolicy">
                                <i class="bi bi-shield-lock me-2"></i> Privacy Policy
                            </button>
                        </h2>
                        <div id="privacyPolicy" class="accordion-collapse collapse" aria-labelledby="policy3" data-bs-parent="#policyAccordion">
                            <div class="accordion-body">
                                <ul>
                                    <li>We collect only essential information (Name, Email, Contact, Payment) to provide our services.</li>
                                    <li>All payments are processed securely; sensitive payment information is never stored.</li>
                                    <li>Personal information is not shared with third parties without consent.</li>
                                    <li>We may use contact details for service updates, notifications, and support communication.</li>
                                    <li>Cookies and analytics may be used to improve platform performance and user experience.</li>
                                    <li>Users may request deletion of their personal data at any time.</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <!-- FAQ Card (Below Policies) -->
            <div class="card p-4">
                <h5><i class="bi bi-question-circle"></i> Frequently Asked Questions</h5>
                <div class="accordion" id="faqAccordion">

                    <div class="accordion-item faq-item">
                        <h2 class="accordion-header" id="faq1">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="false" aria-controls="collapse1">
                                Q1. How do I purchase products on the platform?
                            </button>
                        </h2>
                        <div id="collapse1" class="accordion-collapse collapse" aria-labelledby="faq1" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                Register or login, browse products, add them to your cart, and complete secure payment. Digital products are delivered instantly; physical products are confirmed via order notifications.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item faq-item">
                        <h2 class="accordion-header" id="faq2">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse2" aria-expanded="false" aria-controls="collapse2">
                                Q2. Can I get a refund if something goes wrong?
                            </button>
                        </h2>
                        <div id="collapse2" class="accordion-collapse collapse" aria-labelledby="faq2" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                Refunds are provided if access is not granted or digital products fail. Physical products follow our return policy. Once access or order is confirmed, purchases are non-refundable.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item faq-item">
                        <h2 class="accordion-header" id="faq3">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse3" aria-expanded="false" aria-controls="collapse3">
                                Q3. How does the referral program work?
                            </button>
                        </h2>
                        <div id="collapse3" class="accordion-collapse collapse" aria-labelledby="faq3" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                Invite friends using your referral code. Earn points when they register and make purchases. Points can be redeemed for discounts, free products, or cash rewards.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item faq-item">
                        <h2 class="accordion-header" id="faq4">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse4" aria-expanded="false" aria-controls="collapse4">
                                Q4. What payment methods are supported?
                            </button>
                        </h2>
                        <div id="collapse4" class="accordion-collapse collapse" aria-labelledby="faq4" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                We support UPI, debit/credit cards, net banking, and digital wallets. All transactions are processed securely.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item faq-item">
                        <h2 class="accordion-header" id="faq5">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse5" aria-expanded="false" aria-controls="collapse5">
                                Q5. How can I contact support?
                            </button>
                        </h2>
                        <div id="collapse5" class="accordion-collapse collapse" aria-labelledby="faq5" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                Registered users can reach our support team through the contact form or email for technical help and guidance.
                            </div>
                        </div>
                    </div>

                </div>
            </div>

        </div>

    </div>
</div>

<!-- Footer Include -->
<jsp:include page="footer.html"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
